if ARGV.size != 2
  puts "Sposób użycia: ruby fileSplit.rb <nazwapliku.roz> <bajty_na_fragment>"
  puts "Przykład: ruby fileSplit.rb mojplik.txt 10"
  exit
end

filename = ARGV[0]
size_of_split = ARGV[1]

if File.exists?(filename)
  file = File.open(filename, "r")
  size = size_of_split.to_i
  
  puts "Rozmiar pliku w bajtach: #{File.size(filename)}."
  
  temp = File.size(filename).divmod(size)
  pieces = temp[0]
  extra = temp[1]
  puts "\n#{pieces} części o rozmiarze #{size} bajtów i 1 dodatkowa część o rozmiarze #{extra} bajtów."
  
  pieces.times do |n|
    f = File.open("#{filename}.rsplit#{n}", "w")
	f.puts file.read(size)
  end
  
  e = File.open("#{filename}.rsplit#{pieces}", "w")
  e.puts file.read(extra)
else
  puts "\n\nPlik NIE istnieje - sprawdź, czy dobrze wpisałeś nazwę."
end