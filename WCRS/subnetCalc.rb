require 'ipaddr'

begin
  print "Podaj adres IP: "
  ip = IPAddr.new gets.chomp
  
  print "Podaj maskę sieciową: "
  subnet_mask = IPAddr.new gets.chomp
  
rescue Exception => e
  puts "Wystąpił bład: #{e}\n\n"
end

subnet = ip.mask(subnet_mask.to_s)

puts "Adres podsieci to: #{subnet}\n\n"