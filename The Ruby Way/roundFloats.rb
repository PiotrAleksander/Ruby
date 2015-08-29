class Float 
  EPSILON = 1e-6
  
  def ==(x)
    (self-x).abs < EPSILON
  end
  
  def equals?(x, tolerance=EPSILON)
    (self-x).abs < tolerance
  end
  
  def roundf(miejsca)
    temp = self.to_s.length
	sprintf("%#{temp}.#{miejsca}f", self).to_f
  end
  
  def round2
    whole = self.floor
	fraction = self - whole
	if fraction == 0.5
	  if (whole%2) == 0
	    whole
	  else
	    whole+1
	  end
	else
	  self.round
	end
  end
  
  def roundf2(places)
    shift = 10**places
	(self * shift).round2 / shift.to_f
  end
end
pi = 3.14159
p pi.roundf(4)
p pi.round2
p pi.roundf2(7)
x = 1000001.0/0.003
y = 0.003*x

if y == 1000001.0
  puts "tak"
else
  puts "nie"
end

flag1 = (3.1416).equals? Math::PI
p flag1
flag2 = (3.1416).equals?(Math::PI, 0.001)
p flag2

def commas(x)
  str = x.to_s.reverse
  str.gsub!(/([0-9]{3})/, "\\1,")
  str.gsub(/,$/,"").reverse
end

puts commas 123
puts commas 1234
puts commas 12345
puts commas 123456
puts commas 1234567
