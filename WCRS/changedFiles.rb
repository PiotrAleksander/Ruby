require 'find' #biblioteka przeszukująca drzewa folderów
require 'digest/md5' #biblioteka tworząca i odczytująca sygantury md5(w tym datę utworzenia, id)

unless ARGV[0] and File.directory?(ARGV[0]) #ARGV to zmienna przechowująca opcje podane przy otwieraniu programu
  puts "\n\n\nMusisz podać katalog główny: changedFiles.rb <katalog/>\n\n\n" # podana opcja musi być ścieżką dostępu do katalogu
  exit
end

root = ARGV[0] #root, czyli korzeń drzewa - podstawa wyszukiwania
tablica_pliki = Hash.new
tablica_nowe_pliki = Hash.new
raport_zmian = "#{root}/raport_analityczny.txt"
wyjscie_pliki = "#{root}/lista_plików.txt"
wyjscie_dawne = "#{root}/lista_plików.dawna"

if File.exists?(wyjscie_pliki)
  File.rename(wyjscie_pliki, wyjscie_dawne) #jeżeli skrypt był już uruchamiany przezywa lista_plikow.txt lista_plików.dawna
  File.open(wyjscie_dawne, 'rb') do |wpliku|
    while (temp = wpliku.gets)
	  linia = /(.+)\s{5,5}(\w{32,32})/.match(temp) #regexp szukający sygnatur md5 w wierszach pliku
	  puts "#{linia[1]} ---> #{linia[2]}"
	  tablica_pliki[linia[1]] = linia[2]
	end
  end
end

Find.find(root) do |plik|
  next if /^\./.match(plik) #pomija pliki . i .. - są to znaczniki katalogu i katalogu nadrzędnego
  next unless File.plik?(plik)
  begin
    tablica_nowe_pliki[plik] = Digest::MD5.hexdigest(File.read(plik)) #właściwe zbieranie znaczników
  rescue #wyłapuje ew. błąd i zamiast formułki interpretera wyświetla poniższy "skuztomizowany" błąd
    puts "Błąd odczytu pliku #{plik} --- nie obliczono kodu MMD5." 
  end
end

raport = File.new(raport_zmian, 'wb') #otwiera plik z porównaniem list plików
zmienione_pliki = File.new(wyjscie_pliki, 'wb')

tablica_nowe_pliki.each do |plik, md5|
  zmienione_pliki.puts "#{plik}    #{md5}"
end

tablica_nowe_pliki.keys.select { |plik| tablica_nowe_pliki[plik] == tablica_pliki[plik]}.each do |plik| #rozróżnia pliki wykryte przy wcześniejszych uruchomieniach, ale nie przy obecnym
  tablica_nowe_pliki.delete(plik)
  tablica_pliki.delete(plik)
end

tablica_nowe_pliki.each do |plik, md5|
  raport.puts "#{tablica_pliki[plik] ? "\nZmodyfikowano\n" : "\nDodano\n"} plik: #{plik}    #{md5}" #wyrażenie(tutaj, czy rekord w tablicy istnieje, nie istnieje) ? wynik jeżeli true : wynik jeżeli false
  tablica_pliki.delete(plik)
end

tablica_pliki.each do |plik, md5|
  raport.puts "\nUsunięto/Przeniesiono plik: #{plik} #{md5}\n"
end

raport.close
zmienione_pliki.close
