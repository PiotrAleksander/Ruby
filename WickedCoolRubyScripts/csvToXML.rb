require 'csv'

print "Podaj nazwę pliku CSV: "
nowy_plik = gets.strip

print "Podaj nazwy elementów: "
nazwa_rekordu = gets.strip

print "Podaj tytuł dokumentu XML: "
tytul = gets.strip

print "Podaj nazwę zbioru elementów: "
zbior = gets.strip

plik = CSV.read(nowy_plik, "rb")

naglowek = plik.shift

File.open(File.basename(nowy_plik, ".*") + ".xml", 'wb') do |p|
  p.puts '<?xml version="1.0"?>'
  p.puts "<#{zbior}>"
  p.puts "\t<nazwa>#{tytul}</nazwa>"
  plik.each do |komorka|
    p.puts "\t<#{nazwa_rekordu}"
	for i in 0..(naglowek.size - 1)
	  p.puts "\t\t<#{naglowek[i]}>#{komorka[i]}</#{naglowek[i]}>"
	end
	p.puts "\t</#{nazwa_rekordu}>"
  end
  p.puts "</#{zbior}>"
end