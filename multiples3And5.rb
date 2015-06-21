total = 0
i=0
puts "Podaj ostatnią liczbę"
n = gets.chop
while i<n.to_i
if i%3==0
total +=i
elsif i%5==0
total +=i
end
i+=1
end
puts total
koniec = gets.chop
