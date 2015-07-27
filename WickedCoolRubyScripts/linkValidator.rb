require 'uri'
require 'open-uri'
require 'hpricot'

begin
  print "Podaj adres strony do sprawdzenia (np. http://www.google.pl): "
  url = gets
  puts url
  uri = URI.parse(url)
  html = open(uri).read
rescue Exception => e
  print "Nie można pobrać zasobu: "
  print "Błąd ---- #{e}\n"
end

soup = Hpricot(html)
links = soup.search('a').map { |a| a['href']}

links.delete_if { |href| href =~ /javascript|mailto/}

links.each do |l|
  if l
    begin
	  link = URI.parse(l)
	  link.scheme ||= 'http'
	  link.host ||= uri.host
	  link.path = uri.path + link.path unless link.path[0] == //
	  link = URI.parse(link.to_s)
	  open(link).read
	rescue Exception => e
	  puts "#{link} niepoprawny z powodu błędu #{e}"
	end
  end
end