module SzachyHelper
  def to_idx(pole)
    return pole if pole.is_a? (Fixnum)
    pole[0].ord - 'a'.ord + ('8'.ord - pole[1].ord)*8
  end
  
  def kolor(bierka)
    case bierka
	  when /^[A-Z]$/ then :biale
	  when /^[a-z]$/ then :czarne
	end
  end
  
  def xydiff(poczatek_idx, cel_idx)
    [cel_idx%8 - poczatek_idx%8, cel_idx/8 - poczatek_idx/8]
  end
  
  def to_pole(idx)
    return idx.to_sym if !idx.is_a?(Fixnum)
	y, x = idx.divmod(8)
	((x + 'a'.ord).chr + ('8'.ord - y).chr).to_sym
  end
  
  def to_kol(idx)
    idx.is_a?(String) ? (idx.ord - 'a'.ord) : idx % 8
  end
  
  def to_wiersz(idx)
    idx.is_a?(String) ? '8'.ord - idx.ord : idx / 8
  end
  
  def biale(bierka,b, c)
    case bierka
	  when /^[A-Z]$/, :biale then b
	  when /^[a-z]$/, :czarne then c
	end
  end
end

class Pozycja
  attr_accessor :plansza, :tura, :ep, :roszada, :polruch, :pelenruch
  POLA = [*0..63]
  include SzachyHelper
  
  def initialize(opts = {})
	opts = {:tura => opts} if opts.is_a?(Symbol)
	@plansza = opts[:plansza] || %w(-)*64
	@tura = opts[:tura] || :biale
	@ep = opts[:ep] #porwanie w locie/ en passant
	@roszada = opts[:roszada] || %w(K H k h)
	@polruch = opts[:polruch] || 0
	@pelenruch = opts[:pelenruch] || 1
  end
  
  def initialize_copy(inne) #initialize_copy to słowo kluczowe, wywoływane za każdym #dup instancji klasy
    instance_variables.each do |zmienna|
	  war = instance_variable_get(zmienna)
	  war = war.dup if war.is_a?(Array)
	  self.instance_variable_set(zmienna, war)
	end
  end
  
  def [](idx)
    plansza[to_idx(idx)]
  end
  
  def self.[](str, *args)
    pozycja = Pozycja.new(*args)
	fn = :upcase #funkcja
	str.split.each do |s|
	  case s
	    when /([WSGHK])?([a-h][1-8])/ then pozycja.plansza[to_idx($2)] = ( $1 || "P").send(fn)
	    when ".." then fn = :downcase
	  end
	end
	pozycja
  end
  
  def droga_wolna(poczatek_idx, cel_idx)
    poczatek_idx = to_idx(poczatek_idx)
	cel_idx = to_idx(cel_idx) 
    dx, dy = xydiff(poczatek_idx, cel_idx)
	return true if dx.abs != dy.abs && dx != 0 && dy != 0
	d = (dx <=> 0) + (dy <=> 0)*8
    (poczatek_idx + d).step(cel_idx - d, d).all? { |idx| plansza[idx] == "-"}
  end
  
  def znajdz(bierka, cel_pole)
    cel_idx = to_idx(cel_pole)
	cel_bierka = plansza[cel_idx]
    lista = POLA.select do |poczatek_idx|
	  bierka_poczatek = plansza[poczatek_idx]
	  next if bierka_poczatek != bierka || kolor(cel_bierka) == kolor(bierka)
	  dx, dy = xydiff(poczatek_idx, cel_idx)
	  case bierka.upcase
	    when "W" then dx == 0 || dy == 0
		when "S" then [dx.abs, dy.abs].sort == [1,2]
		when "G" then dx.abs == dy.abs
		when "H" then dx.abs == dy.abs || dx == 0 || dy == 0
		when "K" then [dx.abs, dy.abs].max <= 1
		when "P" then
		  (dx == 0 && dy == biale(bierka, -1, 1) && cel_bierka == "-") ||#jedno pole
	      (dx == 0 && dy == biale(bierka, -2, 2) && poczatek_idx/8 == biale(bierka, 6,1)) && cel_bierka=="-"|| #dwa pola
		  (dx.abs == 1 && dy == biale(bierka, -1, 1) && cel_bierka != "-") ||
		  (dx.abs == 1 && dy == biale(bierka, -1, 1) && to_pole(cel_pole) == ep) #en passant
	  end && droga_wolna(poczatek_idx, cel_idx)
	end
	cel_pole.is_a?(Symbol) ? lista.map {|idx| to_pole(idx)} : lista
  end
  
  def self.setup
    Pozycja.new(:plansza => %w(w s g h k g s w 
											   p p p p p p p p
											   - - - - - - - -
											   - - - - - - - -
											   - - - - - - - -
											   - - - - - - - -
											   P P P P P P P P
											   W S G H K G S W
											   ))
  end
  
  def []=(idx, war)
    plansza[to_idx(idx)] = war
  end
  
  class NiepoprawnyRuch < Exception
    def initialize(str, pozycja)
	  super("#{str}\n#{pozycja}")
	end
  end
  class NiedokladnyRuch < NiepoprawnyRuch; end
  
  def to_s
    p = @plansza.each_slice(8).map {|wiersz| wiersz.join(" ")}.join("\n")
	r = roszada.empty? ? "-" : roszada.join
	"#{p}\nTura:#{tura} Roszada:#{r} Enpassant:#{ep || "-"} Półruch:#{polruch} Ruch:#{pelenruch}"
  end
  
  def ruch_bierki(poczatek_idx, cel_idx)
    poczatek_idx = to_idx(poczatek_idx)
	cel_idx = to_idx(cel_idx)
    plansza[cel_idx] = plansza[poczatek_idx]
	plansza[poczatek_idx] = "-"
  end
  
  def enpassant(bierka, poczatek_idx, cel_idx)
      bierka.upcase == "P" && (cel_idx - poczatek_idx).abs == 16  ? to_pole(poczatek_idx - biale(bierka, 8, -8)) : nil
  end
  
  def szach?
    krol_idx = nil
	POLA.each {|idx| krol_idx = idx if plansza[idx] == biale(tura, "K", "k")}
	krol_idx && poprzez_szach?(krol_idx)
  end
  
  def poprzez_szach?(idx)
    "WSGHKP".send(biale(tura, :downcase, :upcase)).chars.any? {|bierka_przeciwnika| 
	  !znajdz(bierka_przeciwnika, idx).empty?
	}
  end
  
  def procesuj_ruch_bierki(str)
    if m = str.match(/^(?<fig>[WSGHK])?(?<kolumna>[a-h])?(?<wiersz>[1-8])?x?(?<pole>[a-h][1-8])(=(?<promocja>[WSGHK]))?\+?$/)
	  cel_idx = to_idx(m[:pole])
	  bierka = (m[:fig] || "P").send(biale(tura, :upcase, :downcase))
	  lista = znajdz(bierka, cel_idx)
	  lista.select! {|idx| to_kol(idx) == to_kol(m[:kolumna]) } if m[:kolumna]
	  lista.select! {|idx| to_wiersz(idx) == to_wiersz(m[:wiersz]) } if m[:wiersz]
	  lista.reject! {|idx|
	    tmp = self.dup
		tmp.ruch_bierki(idx, cel_idx)
		tmp.szach?
	  }
	  raise NiepoprawnyRuch.new(str, self) if lista.empty?
	  raise NiedokladnyRuch.new(str, self) if 1 < lista.size
	  poczatek_idx = lista[0]
	  ruch_bierki(poczatek_idx, cel_idx)
	  plansza[to_idx(ep)+biale(tura, 8, -8)] = "-" if bierka.upcase == "P" && to_pole(cel_idx) == ep
	  raise NiepoprawnyRuch.new(str, self) if bierka.upcase != "P" && m[:promocja]
	  self[cel_idx] = m[:promocja].send(biale(tura, :upcase, :downcase)) if bierka.upcase == "P" && m[:promocja]
	  @ep =  enpassant(bierka, poczatek_idx, cel_idx)
	  @polruch += 1 if bierka.upcase != "P"
	  true
	else 
	  false
	end
  end
  
  def procesuj_roszade(str)
    if str == "O-O"
	  bierka = "K".send(biale(tura, :upcase, :downcase))
	  raise NiepoprawnyRuch.new(str, self) if !roszada.include?(biale(tura, "K", "k"))
	  raise NiepoprawnyRuch.new(str, self) if !droga_wolna(biale(tura, :e1, :e8), biale(tura, :h1, :h8))
	  ruch_bierki(biale(tura, :e1, :e8), biale(tura, :g1, :g8))
	  ruch_bierki(biale(tura, :h1, :h8), biale(tura, :f1, :f8))
	  raise NiepoprawnyRuch.new(str, self) if szach? || poprzez_szach?(biale(tura, :f1, :f8))
	  @roszada.delete(biale(tura, "K", "k"))
	  @ep =  nil
	  @polruch += 1
	  true
	else
	  false
	end
  end
  
  def procesuj_dluga_roszade(str)
    if str == "O-O-O"
	  bierka = "K".send(biale(tura, :upcase, :downcase))
	  raise NiepoprawnyRuch.new(str, self) if !roszada.include?(biale(tura, "K", "k"))
	  raise NiepoprawnyRuch.new(str, self) if !droga_wolna(biale(tura, :e1, :e8), biale(tura, :a1, :a8))
	  ruch_bierki(biale(tura, :e1, :e8), biale(tura, :c1, :c8))
	  ruch_bierki(biale(tura, :a1, :a8), biale(tura, :d1, :d8))
	  raise NiepoprawnyRuch.new(str, self) if szach?
	  @roszada.delete(biale(tura, "H", "h"))
	  @ep = nil
	  @polruch += 1
	  true
	else
	  false
	end
  end
  
  def ruch(str)
    pozycja = self.dup
	
	wynik = false
	wynik ||= pozycja.procesuj_ruch_bierki(str) 
	wynik ||= pozycja.procesuj_roszade(str) 
	wynik ||= pozycja.procesuj_dluga_roszade(str) 
	raise NiepoprawnyRuch.new(str, self) if wynik == false
	
	pozycja.pelenruch += 1 if tura == :czarne
	pozycja.tura = biale(tura, :czarne, :biale)
	pozycja
  end
end



pozycja = Pozycja.setup
puts pozycja
  loop do
   m = gets.chomp
   pozycja = pozycja.ruch(m)
   puts

   puts pozycja
   puts m
end