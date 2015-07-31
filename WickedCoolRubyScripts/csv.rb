require 'csv'

unless ARGV[0]
  print "Sposób użycia: ruby csv.rb <nazwapliku.roz>"
  print "Przykład: ruby csv.rb plik.csv"
  exit
end

unless File.exist?(ARGV[0])
  print "\nNie można znaleźć pliku - sprawdź ścieżkę."
  print "Sposób użycia: ruby csv.rb plik.csv"
  exit
end

file = CSV.read(ARGV[0], "r")

print "Czy plik zawiera nagłówki (t/n)? "
h = $stdin.gets.chomp

if h.downcase == 't'
  header = file.shift
  print header.join("\t")
  
  file.each do |line|
    puts
	print line.join("\t") 
  end
else
  print "Wpisz nagłówki (rozdzielone przecinkami): "
  header = $stdin.gets.strip
  header = header.split(",")
  header.each do |h|
    print h + "\t"
  end
  
  file.each do |line|
    puts
	line.each do |element|
	  print element + "\t"
	end
  end
end
