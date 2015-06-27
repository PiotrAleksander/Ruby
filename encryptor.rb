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
end
