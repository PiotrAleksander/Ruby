class Pozycja
  attr_accessor :plansza, :tura
  WYMIARY = 3
  KRATKA = WYMIARY * WYMIARY
  
  def initialize(plansza=nil, tura="x")
    @plansza = plansza || %w(-)*KRATKA
	@tura = tura
  end
  
  def ruch(idx)
    pozycja = Pozycja.new(@plansza.dup, xtura("o", "x"))
	pozycja.plansza[idx] = tura
	pozycja
  end
  
  def xtura(x, o)
    tura == "x" ? x : o
  end
  
  def dozwolone_ruchy
    @plansza.map.with_index {|z, i| i if z== "-"}.compact
  end
  
  def wygrana?(tura)
    wiersze = @plansza.each_slice(WYMIARY).to_a
	wiersze.any? {|wiersz| wiersz.all? {|k| k== tura}} ||
	wiersze.transpose.any? {|kolumna| kolumna.all? {|k| k==tura}} ||
	wiersze.map.with_index.all? {|wiersz, i| wiersz[i] == tura} ||
	wiersze.map.with_index.all? {|wiersz, i| wiersz[WYMIARY-1-i.to_i] == tura}
  end
  
  def minimax(glebokosc=1)
    return 100 if wygrana?("x")
	return -100 if wygrana?("o")
	return 0 if dozwolone_ruchy.empty?
	@@minimax ||= {}
	wartosc = @@minimax[@plansza]
	return wartosc if wartosc
	@@minimax[@plansza] = dozwolone_ruchy.map {|idx| 
	ruch(idx).minimax(glebokosc+1)}.send(xtura(:max, :min)) + 
	xtura(-glebokosc, glebokosc) 
  end
  
  def dobry_ruch
    dozwolone_ruchy.send(xtura(:max_by, :min_by)) {|idx| ruch(idx).minimax}
  end
end