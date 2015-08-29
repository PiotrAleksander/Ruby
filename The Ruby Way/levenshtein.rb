class String
  def levenshtein(inny, wst=2, usn=2, zam=1) #inny wyraz do porównania, operacje: wstawiania, usuwania, zamiany
    return nil if self.nil?
	return nil if inny.nil?
	to = []  #tablica odległości
	
	to[0] = (0..self.length).collect {|i| i*wst} #punktacja dla zupełnie odmiennego wyrazu, dla którego należałoby wstawić n=self.length liter
	tresc = [0]*(self.length-1) 
	
	for i in 1..inny.length
	  to[i]=[i*usn, tresc.flatten]
	end
	
	for i in 1..inny.length
	  for j in 1..self.length
	    to[i][j] = [
		  to[i-1][j-1] +
		    (self[j-1] == inny[i-1] ? 0 : zam),
		      to[i][j-1]+ wst,
		  to[i-1][j] + usn
		  ].min
	  end
	end
	
	to[inny.length][self.length]
  end
  
  def similar?(inny, przelom=3) #jeżeli potrzeba więcej niż trzech pkt. akcji (usuwanie=2, wstawianie=2, zamiana=1 ) to nie podobne
    if self.levenshtein(inny)<przelom
	  true
	else
	  false
	end
  end
end