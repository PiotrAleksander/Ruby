print "Wpisz kwotę kredytu: "
loan = gets.chomp.to_i
print "Wpisz czas spłaty kredytu w miesiącach: "
time = gets.chomp.to_i
print "Wpisz oprocentowanie: "
rate = gets.chomp.to_f/100

i = (1+rate/12)**(12/12)-1
annuity = (1-(1/(1+i))**time)/i

payment = loan/annuity

puts "\n%.2f złotego miesięcznie" % payment

