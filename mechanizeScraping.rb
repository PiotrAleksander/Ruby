require 'mechanize'

mechanize = Mechanize.new

strona = mechanize.get('http://stackoverflow.com/')

print strona.title #zwraca string z nazwą strony pobraną z pomiędzy znaczników <head>

strona = mechanize.get('http://www.bbc.co.uk/news/')

print strona.at('#top-story h2').text.strip #zwraca wartość elementu wybranego na podstawie selektora css

strona = mechanize.get('http://en.wikipedia.org/wiki/Main_Page')

link = strona.link_with(text: 'Random article') #przypisuje do zmiennej hiperłącze podpisane jako Random article

strona = link.click #symuluje kliknięcie w łącze

print strona.uri #wyświetla adres łącza

strona = mechanize.get('https://www.gov.uk/')

formularz = strona.forms.first #przypisuje do zmiennej pierwszy(first) formularz

formularz['q'] = 'passport' #w pole q wpisuje 'passport'

strona = formularz.submit #symuluje kliknięcie submit pod formularzem

strona.search('#top-results h3').each do |h3| #szuka po selektorze i dla każdego nagłówka <h3>...
  print h3.text.strip #wyświetla sformatowaną treść nagłówka
end

koniec = gets.chomp