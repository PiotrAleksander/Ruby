require 'thread'
require 'socket'

PORT = 12000
HOST = "96.97.98.99" #tutaj wstawić właściwy adres serwera

waiter = Thread.new do
  puts "Aby przerwać pracę serwera, naciśnij Enter."
  gets
  exit
end

$mutex = Mutex.new
$list = {}

def match?(p1, p2)
  return false if !$list[p1] or !$list[p2]
    
  if ($list[p1][0] == p2 and $list[p2][0] == p1)
    true
  else
    false
  end
end

def handle_client(sess, msg, addr, port, ipname)
  $mutex.synchronize do
    cmd, player1, player2 = msg.split
	p1short = player1.dup
	p2short = player2.split(":")[0]
	player1 << ":#{addr}"
	
	user2, host2 = player2.split(":")
	host2 = ipname if host2 == nil
	player2 = user2 + ":" + IPSocket.getaddress(host2)
	
	if cmd != "login"
	  puts "Bład protokołu: komunikat klienta ma następującą postać: #{msg}"
	end
	
	$list[player1] = [player2, addr, port, ipname, sess]
	
	if match?(player1, player2)
	  p1 = $list[player1]
	  p2 = $list[player2]
	  
	  p1id = "#{p1short}:#{p1[3]}:1"
	  p2id = "#{p2short}:#{p2[3]}:0"
	  sess1 = p1[4]
	  sess2 = p2[4]
	  sess1.puts "#{p2id}"
	  sess2.puts "#{p1id}"
	  sess1.close
	  sess2.close
	end
  end
end

text = nil

$server = TCPServer.new(HOST, PORT)
while session = $server.accept do
  Thread.new(session) do |sess|
    text = sess.gets
	puts "Otrzymano: #{text}"
	domain, port, ipname, ipaddr = sess.peeraddr
	handle_client(sess, text, ipaddr, port, ipname)
	sleep 1
  end
end

waiter.join