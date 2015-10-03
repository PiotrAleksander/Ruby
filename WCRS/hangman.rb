unless ARGV[0] and File.exists?(ARGV[0])
  print "\n\nSposób użycia: hangman.rb <plik.zeSlowami>\n\n"
  exit
end

slowa = File.readlines(ARGV[0])
slowo_zagadka = slowa[rand(slowa.size)].chomp
rozwiazanie = Array.new(slowo_zagadka.length, "-")
slowo_zagadka = slowo_zagadka.split(" ")
litery = []
proby = 10

while proby > 0
  print <<DRUKUJ #ta dowolnie nazywalna stała daje znać o wielowierszowym stringu
    \n\n\nLiczba prób: #{proby}.
    Sprawdzone litery: #{litery}
    Słowo: #{rozwiazanie}
DRUKUJ
    print "Wpisz literę lub zgadnij słowo: "
	proba = $stdin.gets.downcase.chomp
	
	  if proba == slowo_zagadka.to_s
	    print "Zostałeś ułaskawiony!"
		exit
      end
	  if litery.include?(proba)
	    print "Już podałeś tę literę. Spróbuj ponownie..."
		next
	  elsif slowo_zagadka.include?(proba)
	    print "Poprawna litera."
		slowo_zagadka.each_index do |x|
		  if slowo_zagadka[x] == proba
		    rozwiazanie[x] = proba
		  end
		end
	  else
	    print "Niestety - w słowie nie ma podanej litery."
	  end
	  litery << proba
	  proby -= 1
end

print "\n\n\nO nie! Zostałeś POWIESZONY!"
print "Szukane słowo to: #{slowo_zagadka}"
