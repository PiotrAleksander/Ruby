def bez_duplikat(values)
  values.to_a.find_all { |x| values.count(x) == 1 }
end
puts "Proszę o zestaw do przebadania:"
zestaw = gets.chop
bez_duplikat(zestaw)
koniec = gets.chop