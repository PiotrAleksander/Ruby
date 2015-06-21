def palindrom?(sentence)
  strip_sentence = sentence.downcase.gsub(" ","")
  strip_sentence == strip_sentence.reverse
end
puts "Proszę podać zdanie do sprawdzenia:"
pali = gets.chop
while pali.downcase != "koniec"
if palindrom?(pali)
puts "To PALINDROM!"
puts "Proszę podać następne zdanie do sprawdzenia \(albo \"koniec\"\):"
pali = gets.chop
else
puts "To nie palindrom!"
puts "Proszę podać następne zdanie do sprawdzenia \(albo \"koniec\"\):"
pali = gets.chop
end
end
puts "Miłych zdań na przestrzeni dnia!"
koniec = gets.chop

