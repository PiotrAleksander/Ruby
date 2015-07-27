require 'openssl'
require 'socket'
require 'digest/sha1'

priv_key = OpenSSL::PKey::RSA.new(1024)
pub_key = priv_key.public_key

host = ARGV[0] || 'localhost'
port = (ARGV[1] || 8887).to_i

server = TCPServer.new(host, port)

while session = server.accept
  begin
    print "Nawiązano połączenie...trwa wysyłanie klucza publicznego.\n\n"
	print pub_key
	session.print pub_key
	print "Przesłano klucz publiczny - trwa oczekiwanie na przesłanie danych...\n\n"
	
	temp = session.recv(10000)
	print "Otrzymano dane..."
	
	msg = priv_key.private_decrypt(temp)
  rescue => e
    print "Wystąpił problem przy pobieraniu i odszyfrowywaniu danych. "
	print e
  end
  
  command = msg.split("*")
  
  serv_hash = command[0]
  nix_app = command[1]
  win_app = command[2]
  file = command[3]
  
  if Digest::SHA1.hexdigest("#{nix_app}*#{win_app}*#{file}")==serv_hash
    print "Potwierdzono integralność komunikatu..."
	if RUBY_PLATFORM.include?('mswin32')
	  print "Uruchamianie polecenia dla systemu Windows: #{win_app} #{file}"
	  `#{win_app} #{file}`
	  exit
	else
	  print "Uruchamianie polecenia dla systemu Linux: #{nix_app} #{file}"
	  `#{nix_app} #{file}`
	  exit
	end
  else
    print "Nie można przeprowadzić walidacji komunikatu!"
  end
  exit
end
	  