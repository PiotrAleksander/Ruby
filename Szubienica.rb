require 'yaml'

class Szubienica
  def initialize
    zawartosc = File.open('slowa-win.txt', 'r') { |file| file.read } # odczytuje słownik z pliku (tutaj plik angielski od JBerczel)
    poprawne_wyraz = zawartosc.split.select { |slowo| slowo.length.between?(5,12) }  # wybiera słowa 5-12 literowe
    @slowo = poprawne_wyraz[rand(poprawne_wyraz.size)].downcase.split('') #wybiera losowe słowo
    @wyswietl = Array.new(@slowo.length, '_')
    @pudla = Array.new # strzały poza słowo
    @rundy = 6 #rundy do końca
  end

  def graj
    wynik = "Wybacz, ale przegrałeś.  Słowem było: #{@slowo.join}."
    while @rundy > 0
      wyswietl # wyświetla trafione, nietrafione i liczbę pozostałych rund.
      ruch # prompt o literę albo zapis
      if @wyswietl.none? { |i| i == '_' }
        wynik = "#{@wyswietl.join('  ')}\nGratuluję, zgadłeś!"
        @rundy = 0
      end
    end
    puts wynik
	File.unlink('gry/zapis.yaml') if File.exist?('gry/zapis.yaml') #rguelike, jeżeli gra się zakończy to kasuje save'y. Zapobiega to sytuacji zapisu i odkrycia słowa na innym przebiegu.
  end

  # wyswietl
  def wyswietl
    @wyswietl.each { |i| print "#{i}  " }
    puts "\n"
    puts "Nietrafione: #{@pudla.join(', ')}"
    puts "Pozostało prób: #{@rundy}"
  end

  def ruch
    print 'Twój ruch: '
    wejscie = gets.chomp
    puts "\n"
	@rundy -= 1
    if wejscie == 'zapisz'
      zapisz_gre
      puts 'Gra zapisana.', "\n"
	  exit
	elsif wejscie == @slowo.join
	  print "#{@slowo.join}\nGratuluję, zgadłeś!\n"
      print "Zagrać znowu (t/n)? "
	  wejscie = gets.chomp
	  if wejscie.downcase == 't'
	    exec "ruby szubienica.rb"
	  else
	    exit
	  end
    elsif @slowo.none? { |w| w == wejscie } # dodaje pudła i zwiększa rundy, jeżeli słowo nie zawiera litery z ruchu.
      @pudla << wejscie
    else
      @slowo.each_with_index do |litera, i| # dodaje trafione ruchy do wyświetlenia
        @wyswietl[i] = litera if litera == wejscie	
      end
    end
  end
end

def wczytaj_gre
  zawartosc = File.open('gry/zapis.yaml', 'r') { |file| file.read }
  YAML.load(zawartosc) # zwraca obiekt klasy Szubienica
  rescue Exception => b
    print "Nie można otworzyć pliku z powodu #{b}"
end

def zapisz_gre
  Dir.mkdir('gry') unless Dir.exist? 'gry'
  filename = 'gry/zapis.yaml'
  File.open(filename, 'w') do |file|
    file.puts YAML.dump(self)
  end
end

# sprawdza czy polecenie z "menu" jest poprawne.
def polecenie(q)
  wejscie = ''
  until wejscie == 't' || wejscie == 'n'
    print q
    wejscie = gets.chomp
  end
  wejscie
end

# główna pętla programu, takie "menu".
puts "\nWITAJ NA SZUBIENICY\n"
loop do 
  wejscie = polecenie('Chcesz wczytać grę (t/n)? ')
  puts "Zapisać grę w dowolnym momencie możesz wpisując po prostu 'zapisz'."
  gra = wejscie == 't' ? wczytaj_gre : Szubienica.new
  gra.graj
  wejscie2 = polecenie('Zagrać znowu (t/n)? ')
  break if wejscie2 == 'n'
end