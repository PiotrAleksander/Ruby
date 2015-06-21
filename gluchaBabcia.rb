puts "CZEŚĆ WNUSIU"
slowa_wnu = gets.chomp
while slowa_wnu != "do widzenia"
	if slowa_wnu == slowa_wnu.upcase
puts "NIE SŁYSZAŁAM O TYM OD " +rand(1933..1955).to_s+"!"
slowa_wnu = gets.chomp

	else
puts "MOŻESZ GŁOŚNIEJ?"
slowa_wnu = gets.chomp

	end
end
puts "SŁUCHAM?"
slowa2 = gets.chomp
while slowa2 != "do widzenia"
if slowa2 == slowa2.upcase
puts "NIE SŁYSZAŁAM O TYM OD " +rand(1933..1955).to_s+"!"
slowa2 = gets.chomp
else
puts "MOŻESZ GŁOŚNIEJ?"
slowa2 = gets.chomp
end
end
puts "SŁUCHAM?"
slowa3 = gets.chomp

while slowa3 != "do widzenia"
if slowa3 == slowa3.upcase
puts "NIE SŁYSZAŁAM O TYM OD " +rand(1933..1955).to_s+"!"
slowa3 = gets.chomp
else
puts "MOŻESZ GŁOŚNIEJ?"
slowa3 = gets.chomp
end
end

puts "DO WIDZENIA WNUSIU"
czek = gets.chomp