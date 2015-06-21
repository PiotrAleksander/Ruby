puts "Pierwsze imie?"
first_name = gets.chomp
puts "Drugie imie?"
middle_name = gets.chomp
puts "Nazwisko?"
last_name = gets.chomp
puts "Razem znaków: #{first_name.length.to_i + middle_name.length.to_i + last_name.length.to_i}!"
puts "Czy tak jest w istocie?"
check = gets.chomp