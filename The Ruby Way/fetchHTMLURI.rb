require 'open-uri'

data = nil
open("http://www.marsdrive.com/") {|f| data = f.read}

puts "Otrzymano #{data.split.size} wierszy, #{data.size} bajtów."

#ewentualne dalsze przetwarzanie data

#uri = f.base_uri - zwraca obiekt URI z własnymi akcesorami odczytu
#ct = f.content_type - "text/html"
#cs = f.charset - "utf-8"
#ce = f.content_encoding []