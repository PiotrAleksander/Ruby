def substrings(slowo, slownik)
  wyniki = {}
  slownik.each do |s|
    obecny = slowo.downcase
	s = s.downcase
	unless obecny.index(s).nil? #dopóki występuje takie słowo
	  index = obecny.index(s)
	  obecny = obecny[index+1..-1]
	  wyniki.has_key?(s) ? wyniki[s] += 1 : wyniki[s] = 1
	end
  end
  return wyniki
end

puts "Podaj słowo:"
slowo = gets.chomp
puts "Podaj zbiór słów, oddzielonych przecinkiem, który ma zostać przejrzany:"
slownik = gets.chomp.split(" ,").map(&:strip)
puts slownik

puts substrings(slowo, slownik)