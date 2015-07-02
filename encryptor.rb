class Encryptor
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
  def szyfruj_plik(nazwa_pliku, rotacja)
    plik = File.open("nazwa_pliku", "r")
	szyfrowany = plik.read
	zaszyfrowany_tekst = szyfruj(szyfrowany, rotacja)
	plik_wyjsciowy = nazwa_pliku +".szyfr"
	plik_zaszyfrowany = File.open(plik_wyjsciowy, "w")
	plik_zaszyfrowany.write(zaszyfrowany_tekst)
	plik_zaszyfrowany.close
  end
  
  def odszyfruj_plik(nazwa_pliku, rotacja)
    plik = File.open(nazwa_pliku, "r:ASCII-8BIT")
    plik_zaszyfrowany = plik.read
    odszyfrowany_plik = odszyfruj(plik_zaszyfrowany, rotacja)
    plik_wyjsciowy = nazwa_pliku.gsub("szyfr", "odszyfr")
    plik_odszyfrowany = File.open(plik_wyjsciowy, "w")
    plik_odszyfrowany.write(odszyfrowany_plik)
    plik_odszyfrowany.close
  end
end
