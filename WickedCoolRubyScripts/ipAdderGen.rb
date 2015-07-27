class IP
  def initialize(ip)
    @ip = ip
  end
  
  def to_s
    @ip
  end
  
  def==(other)
    to_s==other.to_s
  end
  
  def succ
    return @ip if @ip == "255.255.255.255"
	parts = @ip.split('.').reverse
	parts.each_with_index do |part, i|
	  if part.to_i < 255
	    part.succ!
		break
	  elsif part == "255"
	    part.replace("0") unless i == 3
	  else
	    raise ArgumentError, "Niepoprawna liczba #{part} w adresie IP"
	  end
	end
	parts.reverse.join('.')
  end
  
  def succ!
    @ip.replace(succ)
  end
end

print "Podaj początkowy adres IP:"
start_ip = gets.strip

print "Podaj końcowy adres IP:"
end_ip = gets.strip

i = IP.new(start_ip)

ofile = File.open("ips.txt", "w")
ofile.puts i.succ! until i == end_ip
ofile.close

print "Sprawdź plik ips.txt"