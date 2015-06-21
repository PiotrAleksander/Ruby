def suma_szescianu(a, b)
  (a..b).inject(0) { |sum, x| sum += (x**3) }
end
puts "Program prosi o pierwszą liczbę z zakresu:"
odp1 = gets.chop
puts "Program prosi o ostatnią liczbę z zakresu:"
odp2 = gets.chop
while ((odp1.downcase != 'koniec')||(odp2.downcase != 'koniec')) #while nie kończy pętli na warunku pierwszy po inpucie "koniec", ale sprawdza jeszcze odp2
puts suma_szescianu(odp1.to_i, odp2.to_i)
puts "Program prosi o pierwszą liczbę z zakresu:"
odp1 = gets.chop
puts "Program prosi o ostatnią liczbę z zakresu:"
odp2 = gets.chop
end
koniec = gets.chop


