class Enkryptor
  def szyfr(rotacja)
    znaki = (' '..'z').to_a
    odwrocone_znaki = znaki.rotate(rotacja)
    Hash[znaki.zip(odwrocone_znaki)]
  end
  
  def szyfruj_znak(znak,rotacja)
  szyfr_rotacja = szyfr(rotacja)
  szyfr_rotacja[znak]
end
  
  def szyfruj(slowo, rotacja)
	znaki = slowo.split("")
    wynik = znaki.collect do |znak|
      szyfruj_znak(znak, rotacja)
    end
	wynik.join
  end

  def odszyfruj_znak(znak, rotacja)
    szyfr_rotacja = szyfr(-rotacja)
	szyfr_rotacja[znak]
  end

  def odszyfruj(slowo, rotacja)
	znaki = slowo.split("")
    wynik = znaki.collect do |znak|
      odszyfruj_znak(znak, rotacja)
    end
	wynik.join
  end
end

puts "To narzędzie to enkryptor. Czy chcesz [s]zyfrować, czy [o]odszyfrować wiadomość? (wyjście z programu to [q])"
odp1 = gets.chomp

while odp1.downcase != "q"
  if odp1.downcase == "s"
    puts "Proszę wprowadzić zdanie:"
	slowo = gets.chomp
	puts "Proszę wprowadzić rotację:"
	rotacja = gets.chomp().to_i
	rezultat = Enkryptor.new
	puts rezultat.szyfruj(slowo, rotacja)
	puts "To narzędzie to enkryptor. Czy chcesz [s]zyfrować, czy [o]odszyfrować wiadomość? (wyjście z programu to [q])"
	odp1 = gets.chomp
  elsif odp1.downcase == "o"
    puts "Proszę wprowadzić zaszyfrowane zdanie:"
	slowo = gets.chomp
	puts "Proszę wprowadzić spodziewaną rotację:"
	rotacja = gets.chomp().to_i
	rezultat = Enkryptor.new
	puts rezultat.odszyfruj(slowo, rotacja)
    puts "To narzędzie to enkryptor. Czy chcesz [s]zyfrować, czy [o]odszyfrować wiadomość? (wyjście z programu to [q])"
	odp1 = gets.chomp
  else
    puts "Nieprawidłowa komenda"
	puts "To narzędzie to enkryptor. Czy chcesz [s]zyfrować, czy [o]odszyfrować wiadomość? (wyjście z programu to [q])"
	odp1 = gets.chomp
  end
end
puts "Miłych wiadomości na przestrzeni dnia!"
koniec = gets.chomp