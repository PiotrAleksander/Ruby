require 'zip/zip'

unless ARGV[0]
  puts "Sposób użycia: ruby compress.rb <nazwa_pliku.roz>"
  puts "Przykład: ruby compress.rb moj_plik.exe"
  exit
end

file = ARGV[0].chomp

if File.exists?(file)
  print "Podaj nazwę pliku zip: "
  zip = "#{$stdin.gets.chomp}.zip "
  Zip::ZipFile.open(zip, true) do |zipfile|
    begin
	  puts "Dodawanie do archiwum pliku #{file}."
	  zipfile.add(file, file)
	  puts "Zakończono."
	rescue Exception => e
	  puts "W czasie kompresji wystąpił błąd: \n #{e}"
	end
  end
else
  puts "\nNie znaleziono pliku."
end