przyjaciel = "hfCghHIE5LAM."

print "Powiedz \"przyjaciel\" i wejdź!\n"
haslo = gets.chop

if haslo.crypt("hf") == przyjaciel
  print "Witaj!"
else
  print "Kim jesteś, orkiem?"
end