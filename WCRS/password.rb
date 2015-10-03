unless ARGV[0]
  print "Musisz podać hasło do sprawdzenia."
  print "Sposób użycia: ruby password.rb mojeTajneHasło"
  exit
end

password = ARGV[0]
word = password.split(//)
letters = Hash.new(0.0)
set_size = 96

word.each do |i|
  letters[i] += 1.0
end

letters.keys.each do |j|
  letters[j] /= word.length
end

entropy = -1 * letters.keys.inject(0.to_f) do |sum, k|
  sum + (letters[k] * (Math.log(letters[k])/Math.log(2.to_f)))
end

combinations = 96 ** password.length

days = combinations.to_f / (10000000 * 86400)

years = days / 365

print "\nPoziom entropii to: #{entropy}"
print "\nZłamanie hasła atakiem siłowym zajmie około #{days <365 ? "#{days.to_i} dni" : "#{years.to_i} lat"}"