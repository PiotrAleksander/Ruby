require 'socket'
require 'timeout'

ChessServer = '96.97.98.99' #należy zastąpić faktycznym

ChessServerPort = 12000
PeerPort = 12001

WHITE, BLACK = 0, 1
Colors = %w[White Black]

def draw_board(board)
  puts <<-EOF
+----------------------------------------+
| Namiastka! Rysujemy szachownicę... |
+----------------------------------------+
  EOF
end

def analyze_move(who, move, num, board)
  if who == BLACK and num == 4
    move << "	Szach i mat!"
  end
  true
end

def my_move(who, lastmove, num, board, sock)
  ok = false
  until ok do
    print "\nTwój ruch: "
	move = STDIN.gets.chomp
	ok = analyze_move(who, move, num, board)
	puts "Nieprawidłowy ruch" if not ok
  end
  sock.puts move
  move
end

def other_move(who, move, num, board, sock)
  move = sock.gets.chomp
  puts "\nRuch przeciwnika: #{move}"
  move
end

if ARGV[0]
  myself = ARGV[0]
else
  print "Wpisz swoje dane: "
  myself = STDIN.gets.chomp
end

if ARGV[1]
  opponent_id = ARGV[1]
else
  print "Wpisz dane swojego przeciwnika: "
  opponent_id = STDIN.gets.chomp
end

opponent = opponent_id.split(":")[0]

socket = TCPSocket.new(ChessServer, ChessServerPort)

response = nil

socket.puts "login #{myself} #{opponent_id}"
socket.flush
response = socket.gets.chomp

name, ipname, color = response.split(":")
color = color.to_i

if color == BLACK
  puts "\nNawiązywanie połączenia..."
  
  server = TCPServer.new(PeerPort)
  session = server.accept
  
  str = nil
  begin
    timeout(30) do
	  str = session.gets.chomp
	  if str != "ready"
	    raise "Błąd protokołu: zamiast komunikatu gotowości otrzymano: #{str}"
	  end
	end
  rescue TimeoutError
    raise "Nie otrzymano komunikatu o gotowości przeciwnika."
  end
  
  puts "Grasz białymi figurami z #{opponent}.\n"
  
  who = WHITE
  move = nil
  board = nil
  
  num = 0
  draw_board(board)
  
  loop do
    num += 1
	move = my_move(who, move, num, board, session)
	draw_board(board)
	case move
	  when "resign"
	    puts "\nPoddałeś partię. #{opponent} wygrał."
		break
	  when /Szach/
	    puts "\nWygrałeś partię z #{opponent}!"
		draw_board(board)
		break
	end
	move = other_move(who, move, num, board, session)
	draw_board(board)
	case move
	  when "resign"
	    puts "\nPoddałeś partię. #{opponent} wygrał."
		break
	  when /Szach/
	    puts "\nWygrałeś partię z #{opponent}!"
		draw_board(board)
		break
	end
  end
else
  puts "\nNawiązywanie połączenia..."
  
  socket = TCPSocket.new(ipname, PeerPort)
  socket.puts "ready"
  
  puts "Grasz czarnymi figurami z #{opponent}.\n"
  
  who = BLACK
  move = nil
  board = nil
  
  num = 0
  draw_board(board)
  
  loop do
    num += 1
	move = other_move(who, move, num, board, session)
	draw_board(board)
	case move
	  when "resign"
	    puts "\n#{opponent} poddał partię... wygrałeś!"
		break
	  when /Szach/
	    puts "\n#{opponent} wygrał partię."
		draw_board(board)
		break
	end
	move = my_move(who, move, num, board, session)
	draw_board(board)
	case move
	  when "resign"
	    puts "\nPoddałeś partię. #{opponent} wygrał."
		break
	  when /Szach/
	    puts "\nWygrałeś partię z #{opponent}!"
		draw_board(board)
		break
	end
  end
  socket.close
end