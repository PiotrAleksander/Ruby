def zmiana(wzorzec) #zmiana jak praca zmianowa
  indeks = Hash.new
  m = wzorzec.length
  a = (' '..'z').to_a
  a.each_with_index {|i| indeks[i] = m}
  for i in 0...(m-1)
    indeks[wzorzec[i]] = m - i - 1
  end
  return indeks
end  

def bm(igla, stog) #algorytm tutaj to chyba implementacja Horspoola
  indeks = zmiana(igla) #tworzy liczby od 1 do n dla każdej litery igly
  m = igla.length
  n = stog.length
  i = j = m-1 #sprawdza ostatnią literę igly
  while (stog[i]!=igla[j]) #litera stogu nie równa się literze 
    x = indeks[stog[i]] #dla indeksu określa maksymalny skok w stogu. W sensie, jeżeli nawet ostatnia litera się nie zgadza(boyermoore porównuje ostatnie litery), to podczas skoku o całą igłę, moglibyśmy minąć nowy początek porównania. Indeks określa więc o ile mniej musi skoczyć znowu, żeby aktualny indeks stogu dopasować do nieostatniej litery wzorca. Jeżeli wystąpi zgodność, to porównuje poprzedni znak. 
	if (m-j>x)
	  i += m-j #i to indeks porównywanego znaku, ale po stronie stogu
	else
	  i+=x
	  if i>=n
	    return -1
	  end
	end
	j=m-1 #jeżeli wystąpi niezgodność na nieostatnim znaku, znowu skaczemy o całą długość wyrazu
  end
  return i #zwraca pozycję trafnego porównania ostatniej litery tekstu i odejmuje długość wzorca, zwracając pozycję pierwszego znaku trafienia.
end