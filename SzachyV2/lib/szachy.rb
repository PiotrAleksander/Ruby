module SzachyHelper
  ('a'..'h').each.with_index do |kol, i|
    (1..8).each.with_index  do |wiersz, j|
	  define_method("#{kol}#{wiersz}") {i+1 + (8 -j + 1)*10 }
	end
  end
end

class Fixnum
  def to_pole
    (self%10 + 'a'.ord - 1).chr + ('8'.ord - self/10 + 2).chr
  end
end

class String
  def to_idx
    self[0].ord - 'a'.ord + 1 + ('8'.ord - self[1].ord + 2)*10
  end
end

class Symbol
  def pionek?
    self == :P || self == :p
  end
  
  def krol?
    self == :K || self == :k
  end
  
  def kolor
	return @kolor unless @kolor.nil?
	@kolor = :a < self ? :czarne : :biale
  end
end

class NiedozwolonyRuch < Exception
  def initialize(str, pozycja, lista)
    super("#{str}\n#{pozycja}" + (lista.empty? ? "" : lista.map {|z| z.to_pole}.inspect))  
  end
end

class Pozycja
  include SzachyHelper
  attr_accessor :plansza, :tura, :roszada, :ep, :polruch, :pelenruch, :krol
  def initialize(arg={})
    if arg.keys.any? {|k| k.size == 1}
	  @plansza = [nil]*120
	  arg.each do |b, idxy|
	    next if b.size != 1
		idxy = [idxy] unless Array === idxy
		idxy.each do |idx|
		  @plansza[idx] = b
		end
	  end
	else
    @plansza = %w(- - - - - - - - - -
							- - - - - - - - - -
							- w s g h k g s w -
							- p p p p p p p p -
							- - - - - - - - - -
							- - - - - - - - - -
							- - - - - - - - - -
							- - - - - - - - - -
							- P P P P P P P P -
							- W S G H K G S W -
							- - - - - - - - - -
							- - - - - - - - - -).map {|c| c == "-" ? nil : c.to_sym}
	end
	@tura = arg[:tura] || :biale
	@roszada = arg[:roszada] || "KHkh"
	@ep = arg[:ep]
	@polruch = arg[:polruch] || 0
	@pelenruch = arg[:pelenruch] || 1
	@krol = {biale: @plansza.index(:K), czarne: @plansza.index(:k)}
  end
  
  def initialize_copy(kopia)
    @plansza = kopia.plansza.dup
	@tura = kopia.tura
	@roszada = kopia.roszada.dup
	@ep = kopia.ep
	@polruch = kopia.polruch
	@pelenruch = kopia.pelenruch
	@krol = kopia.krol.dup
  end
  
  def self.[](opcje)
    Pozycja.new(opcje)
  end
  
  def ==(porownanie)
    @plansza == porownanie.plansza && 
	@tura == porownanie.tura &&
	@roszada == porownanie.roszada &&
	@ep == porownanie.ep &&
	@polruch == porownanie.polruch &&
	@pelenruch == porownanie.pelenruch
  end
  
  def to_s
    p = @plansza.each_slice(10).to_a[2..9].map {|wiersz| wiersz[1..8].map {|s| s || "-"}.join(" ")}.join("\n")
	r = roszada.empty? ? :- : roszada
	e = ep.nil? ? :- : ep.to_pole
	"#{p} #{tura} #{r} #{e} #{polruch} #{pelenruch}"
  end
  
  def biale(b, c, t=tura)
    t == :biale ? b : c
  end

  def ruch_str(poczatek, cel)
    bierka = plansza[poczatek]
	bierka_str = bierka.pionek? ? "" : bierka
	lista = znajdz(bierka, cel)
	kaptaz = plansza[cel] || bierka.pionek? && cel == ep
	if bierka.pionek? && kaptaz #TA SEKCJA MO¯E PIERDOLN¥Æ pod niewykorzystaniem metody kolor. 
	  pionki_poz = [*0..7].select {|wiersz| plansza[poczatek%10 + (wiersz+2)*10] == bierka}.select {|wiersz| cele = plansza[cel%10 + (wiersz+2+biale(-1, 1))*10]; cele && ((cele.to_s.ord - bierka.to_s.ord)>=16)   } #cele && cele.kolor != bierka.kolor (can't modify frozen Symbol)
	  if pionki_poz.size == 1
	    "#{poczatek.to_pole[0]}#{cel.to_pole[0]}"
	  else
	    "#{poczatek.to_pole[0]}#{cel.to_pole}"
	  end
	elsif bierka.krol? && cel - poczatek == 2
	  "O-O"
	elsif bierka.krol? && cel - poczatek == -2
	  "O-O-O"
	else
	  if lista.size == 1
        "#{bierka_str}#{cel.to_pole}"
      elsif lista.select {|idx| idx%10 == poczatek%10}.size == 1
        "#{bierka_str}#{poczatek.to_pole[0]}#{cel.to_pole}"
	  elsif lista.select {|idx| idx/10 == poczatek/10}.size == 1
        "#{bierka_str}#{poczatek.to_pole[1]}#{cel.to_pole}"
	  else
	    "#{bierka_str}#{poczatek.to_pole}#{cel.to_pole}"
	  end
    end	
  end
  
  def znajdz_rekur(bierka, cel, kierunki, powtorz) #poruszanie siê wiêcej ni¿ o jedno pole
    lista = []
	kierunki.each do |kier|
	  if powtorz
	    poczatek = cel + kier
	    while 21 <= poczatek && poczatek <= 98 && poczatek%10 != 0 && poczatek%10 != 9
		  lista.push(poczatek) if plansza[poczatek] == bierka 
		  break if plansza[poczatek]
		  poczatek += kier
		end
	  else
	    poczatek = cel + kier
		lista.push(poczatek) if plansza[poczatek] == bierka
	  end
	end
	lista
  end
  
  def znajdz(bierka, cel)
	case bierka
	when :P, :p then
	  lista = []
	  kolor = bierka == :P ? :biale : :czarne
	  if plansza[cel] || cel == ep
	    [11,9].each do |kier|
	      poczatek = cel + biale(kier,-kier, kolor)
		  lista.push(poczatek) if plansza[poczatek] == bierka
		end	    
	  else
	    poczatek = cel + biale(10, -10, kolor)
	    lista.push(poczatek) if plansza[poczatek] == bierka
	    poczatek = cel + biale(20, -20, kolor)
	    lista.push(poczatek) if plansza[poczatek] == bierka && cel/10 == biale(6,5,kolor) && plansza[(cel+poczatek)/2] == nil
	  end
	  lista
	when :W, :w then znajdz_rekur(bierka, cel, [-10, -1, 1, 10], true)
	when :S, :s then znajdz_rekur(bierka, cel, [-21, -19, -12, -8, 8, 12, 19, 21], false)
	when :G, :g then znajdz_rekur(bierka, cel, [-11,-9,9,11], true)
	when :H, :h then znajdz_rekur(bierka, cel, [-11, -10, -9, -1, 1, 9, 10, 11], true)
	when :K, :k then
	  lista = znajdz_rekur(bierka, cel, [-11, -10, -9, -1, 1, 9, 10, 11], false)
	  if @plansza[cel].nil?
	    krol_idx = krol[tura]
		if cel == biale(g1,g8) && krol_idx == biale(e1, e8)
		  lista.push(krol_idx)
		end
	  end
	  lista
	end
  end
  
  def szach?
    return false if krol[tura].nil?
    biale([:w, :s, :g, :h, :k, :p], [:W, :S, :G, :H, :K, :P]).any? {|bierka| !znajdz(bierka, krol[tura]).empty?}
  end
  
  def ruch(*args)
    if args.size == 1
	  str = args[0]
	  lista = []
	else
	  str =""
	  lista = [args[0]]
	  cel = args[1]
	  bierka = @plansza[args[0]]
	end
	kaptaz = false #bicie
	if r = str.match(/^(?<bierka>[WSGHK])? (?<kolumna>[a-h])?(?<wiersz>[1-8])? x? (?<pole>[a-h][1-8]) (=(?<awans>[WSGHK]))? \+?$/x)
	  bierka = r[:bierka] || "P"
	  bierka.downcase! if tura == :czarne
	  bierka = bierka.to_sym
	  awans = r[:awans] if r[:awans]
	  awans.downcase! if awans && tura == :czarne
	  awans = awans.to_sym if awans
	  cel = r[:pole].to_idx
	  kolumna = r[:kolumna].ord - 'a'.ord + 1 if r[:kolumna]
	  wiersz = '8'.ord - r[:wiersz].ord + 2 if r[:wiersz]
      lista = znajdz(bierka, cel)
	  lista.select! {|poczatek| poczatek%10 == kolumna} if kolumna
	  lista.select! {|poczatek| poczatek/10 == wiersz} if wiersz
	  kaptaz_ep = bierka.pionek? && cel == ep
      kaptaz = plansza[cel] || kaptaz_ep  
	elsif str == "O-O-O" && roszada.include?(biale("H", "h"))
	  bierka = biale(:K, :k)
	  cel = biale(c1, c8)
	  lista.push(biale(e1, e8))
	  plansza[biale(d1, d8)] = plansza[biale(a1, a8)]
	  plansza[biale(a1, a8)] = nil
	  roszada.delete(biale("H", "h"))
	elsif str == "O-O" && roszada.include?(biale("K", "k"))
	  bierka = biale(:K, :k)
	  cel = biale(g1, g8)
	  lista.push(biale(e1, e8))
	  plansza[biale(f1, f8)] = plansza[biale(h1, h8)]
	  plansza[biale(h1, h8)] = nil
	  roszada.delete(biale("K", "k"))
	end
	lista.select! {|poczatek| 
	  kopia = self
	  kopia_krol = kopia.krol[tura]
	  kopia.krol[tura] = cel if bierka.krol?
	  kopia_bierka = kopia.plansza[cel]
	  kopia.plansza[cel] = kopia.plansza[poczatek]
	  kopia.plansza[poczatek] = nil
	  jest_szachowany = kopia.szach?
	  kopia.plansza[poczatek] = kopia.plansza[cel]
	  kopia.plansza[cel] = kopia_bierka
	  kopia.krol[tura] = kopia_krol
	  !jest_szachowany
	}
    raise NiedozwolonyRuch.new(str, self, lista) if lista.size != 1
	poczatek = lista[0]
	@krol[tura] = cel if bierka.krol?
	plansza[ep + biale(10, -10)] = nil if kaptaz_ep
    @ep = bierka.pionek? && cel - poczatek == biale(-20, 20)	? (cel+poczatek)/2 : nil
	plansza[cel] = awans || plansza[poczatek]
	plansza[poczatek] = nil
	@pelenruch += 1 if tura == :czarne
	if bierka.pionek? || kaptaz
	  @polruch = 0
	else
	  @polruch+=1
	end
	@tura = biale(:czarne, :biale)
	self
  end
  
  def dozwolone_ruchy
    lista = []
	bierki = biale([:W, :S, :G, :H, :K, :P], [:w, :s, :g, :h, :k, :p])
	[*0..7].each do |i|
	  [*0..7].each do |j|
	    idx = i + 1 + (j+ 2)*10
		bierki.each do |b|
		  lista += znajdz(b, idx).map {|poczatek| [poczatek, idx] }
		end
	  end
	end
	lista
  end
  
  def dozwolone_ruchy_str
    dozwolone_ruchy.map {|poczatek, cel| ruch_str(poczatek, cel)}
  end
  
  def wartosciuj
    wynik = 0
	wynik += @plansza.count(:W)*5
	wynik += @plansza.count(:S)*3
	wynik += @plansza.count(:G)*3
	wynik += @plansza.count(:H)*9
	wynik += @plansza.count(:P)*1
	wynik -= @plansza.count(:w)*5
	wynik -= @plansza.count(:s)*3
	wynik -= @plansza.count(:g)*3
	wynik -= @plansza.count(:h)*9
	wynik -= @plansza.count(:p)*1
	wynik
  end
  
  def potomne
    dozwolone_ruchy.map {|poczatek, cel| 
	begin
	  dup.ruch(poczatek, cel)
	rescue
	  nil
	end
	}.compact
  end
end