class Sterta #działa dość nieprzyjemnie dla tablic poniżej ~10 elementów
  attr_reader :a
  def initialize(a=[]) #inicjalizowany z tablicą priorytetowości elementów
    @a = a
    tworz(@a)
  end
  
  def tworz(sterta)
	rozmiar = sterta.length
	i = (rozmiar/2) -1
	while i>=0
	  na_dol(sterta,i,rozmiar)
	  i-=1
	end
	
	i=rozmiar-1
  
    while i >= 1
      sterta[0], sterta[i] = sterta[i], sterta[0]
	  na_dol(sterta, 0, i -1)
	  i -= 1
    end
    return sterta
  end

  def wstaw(tab)
	tab.each do |elem|
	  @a << elem
	end
	tworz(@a)
  end

  def na_dol(num, szczyt, dol)
    koniec = false
    galezie = 0 
  
    while szczyt*2 < dol and !koniec
      if szczyt*2 == dol
	    galezie = szczyt*2
	  elsif num[szczyt*2].to_i > num[szczyt*2+1].to_i
	    galezie = szczyt*2
	  else
	    galezie = szczyt*2+1
	  end
      if num[szczyt] < num[galezie]
   	    num[szczyt], num[galezie] = num[galezie], num[szczyt]
	    szczyt = galezie
	  else
	    koniec = true
	  end
    end  
  end

  def obsluz
    while @a.length != 0
      begin
        print "#{@a.shift} do obsługi.\n"#albo first jeżeli zależy nam na zachowaniu oryginalnej tablicy
		gets.chomp
	  rescue Exception => e
	    print "Wystąpił błąd: #{e}\n"
  	  end
	end
	print "Koniec listy."
  end
end