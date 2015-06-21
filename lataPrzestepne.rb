puts 'rok początkowy:'
s = gets.chop
puts 'rok końcowy:'
e = gets.chop
if s.to_i > e.to_i
puts 'początkowy powinien być mniejszy'
else
puts 'lata przestępne pomiędzy ' + s + ' i '+ e + ':'
end

while s.to_i < e.to_i

while ( (s.to_i % 4 == 0 and s.to_i % 100 != 0) or (s.to_i % 100 ==
0 and s.to_i % 400 == 0 ))
puts s
s = s.to_i + 1
end
s = s.to_i + 1
end
puts 'już!'
fajne = gets.chop