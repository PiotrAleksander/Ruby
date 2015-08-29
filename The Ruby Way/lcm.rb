#LCM - Least Common Multiple, Najmniejsza Wspólna Wielokrotność

require 'mathn'

class Integer
  def lcm(liczba)
    pf1 = self.prime_division.flatten #spłaszczona tablica czynników pierwszych liczby na której wywołujemy metodę
	pf2 = liczba.prime_division.flatten #to samo dla liczby z której niejmniejszej wspólnej wielokrotności szukamy
	h1 = Hash[*pf1] #* jest potrzebny, by metoda spodziewała 
	h2 = Hash[*pf2]
	hash = h2.merge(h1) {|klucz, stary, nowy| [stary, nowy].max} #wszytkie klucze, jeżeli się powtarzają czynniki pierwsze, bierze to w większej potędze
	Integer.from_prime_division(hash.to_a)
  end
end