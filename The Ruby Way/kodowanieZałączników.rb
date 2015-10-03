bin = File.read("new.gif")
str = [bin].pack("m") #dyrektywa "m" dla algorytmu base64 (brzmi jak rot z ASCII m zamiast np. 13(chociaż "m".ord =109))

orig = str.unpack("m")[0]

#starszy format wykorzystujący operacje uuencode i uudecode scala załącznik z wiadomością:

filename = "new.gif"
bin = File.read(filename)
encoded = [bin].pack("u")

mailtext << "begin 644 #{filename}"
mailtext << encoded
mailtext << "end"

#teraz strona kliencka wyobdrębniająca załącznik od wiadomości
#attached reprezentuje zakodowane dane aż do "end"

lines = attached.split("\n")
filename = /begin \d\d\d (.*)/.scan(lines[0]).first.first
encoded = lines[1..-2].join("\n")
decoded = encoded.unpack("u")
#decoded jest gotów do zapisania do pliku