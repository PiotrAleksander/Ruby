def sortowanie_babelkowe(tablica)
  loop do
  i, x = 0, 0 #x to zmienna pomocnicza
    while i < tablica.length - 1
	  if tablica[i + 1] < tablica[i]
      tablica[i], tablica[i + 1] = tablica[i + 1], tablica[i]
      x += 1 #służąca za znacznik przebiegu sortowania
	  end
      i += 1
    end
    break if x == 0 # i wyłączy pętle, jeżeli tablica jest, bądź była posortowana
  end
  tablica
end

def sortowanie_poprzez(tablica)
  loop do
  i, x = 0, 0
    while i < tablica.length - 1
      if yield(tablica[i], tablica[i + 1]) > 0
      tablica[i], tablica[i + 1] = tablica[i + 1], tablica[i]
      x += 1
      end
      i += 1
    end
    break if x == 0
  end
  tablica
end
p sortowanie_babelkowe("zdanie, które zaraz zostanie posortowanie".split)
