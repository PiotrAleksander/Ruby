require 'socket'
require 'digest/sha1'

begin
  print "Uruchamianie klienta..."
  client = TCPSocket.new('localhost', 8887)
  
  print "nawiązano połączenie!\n\n"
  
  temp = " "
  5.times do
    temp << client.gets 
  end
  print "Otrzymano 1024-bitowy klucz publiczny RSA!\n\n"
  
  public_key = OpenSSL::PKey::RSA.new(temp)
  msg = 'mpg123*"C:\Program Files\Windows Media Player\wmplayer.exe"*ruby.mp3'
  sha1 = Digest::SHA1.hexdigest(msg)
  
  command = public_key.public_encrypt("#{sha1}*#{msg}")
  print "Przesyłanie polecenia..."
  
  client.send(command, 0)
  
  print "wysłane!"
rescue => e
  print "Wystąpił problem..."
  print e
  retry
end

client.close