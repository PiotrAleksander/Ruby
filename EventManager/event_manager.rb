require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "2ff0cf63048d45ec879fcf87b4d28a88" #klucz ze strony Sunlight - zajmują się przejrzystością kongresu

def oczysc_kod_pocztowy(kod_pocztowy) #
  kod_pocztowy.to_s.rjust(5,"0")[0..4]
end

def poslowie_kod_pocztowy(kod_pocztowy)
  Sunlight::Congress::Legislator.by_zipcode(kod_pocztowy)
end

def list_z_podziekowaniem(id,szablon_list)
  Dir.mkdir("listy") unless Dir.exists?("listy") #tworzy katalog "listy", jeżeli nie istnieje

  nazwa_pliku = "listy/dzieki_#{id}.html" #tworzy szablony pod legislatora(członka senatu)

  File.open(nazwa_pliku,'w') do |plik|
    plik.puts szablon_list
  end
end

puts "EventManager zainicjowany." #zostaje po angielsku, póki są legislatorzy

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "szablon_list.erb" # wczytuje szablon z wpisanymi formułami ruby (tworzą spersonalizowane wersje strony)
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  kod_pocztowy = oczysc_kod_pocztowy(row[:zipcode]) # zipcode to nazwa wiersz z event_attendees.csv
  legislators = poslowie_kod_pocztowy(kod_pocztowy)

  szablon_list = erb_template.result(binding)

  list_z_podziekowaniem(id,szablon_list)
end


koniec = gets.chop