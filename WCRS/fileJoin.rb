if ARGV.size != 1
  puts "Sposób użycia: ruby fileJoin.rb <nazwapliku.roz>"
  puts "Przykład: ruby fileJoin.rb mojplik.txt"
  exit
end

file = ARGV[0]
piece = 0
orig_file = "Nowy.#{file}"

if File.exists?("#{file}.rsplit#{piece}")
  ofile = File.open(orig_file, "w")
  while File.exists?("#{file}.rsplit#{piece}")
    puts "Wczytywanie pliku: #{file}.rsplit#{piece}"
	ofile << File.open("#{file}.rsplit#{piece}", "r").read.chomp
	piece+=1
  end
  ofile.close
  puts "\nSukces! Plik odtworzono."
else
  puts "\n\nNie można znaleźć pliku #{file}.rsplit#{piece}."
end