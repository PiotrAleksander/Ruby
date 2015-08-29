require 'socket'

PORT = 12321
HOST = ARGV[0] || 'localhost'

server = TCPServer.new(HOST, PORT)

while (session=server.accept)
  Thread.new(session) do |my_session|
    my_session.puts Time.new
    my_session.close
  end
end