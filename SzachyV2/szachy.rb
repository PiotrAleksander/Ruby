require 'gosu'
require 'debugger'
require './lib/szachy.rb'

class Szachy < Gosu::Window
  attr_accessor :szer, :wys, :kszer, :pozycja, :czcionka, :poczatek, :cel, :gracz #szerokość, wysokość, komórka_szerokość
  BIERKI = {W: "W", S: "S", G: "G", H: "H", K: "K", P: "P", w: "w", s: "s", g: "g", h: "h", k: "k", p: "p"}
  
  def initialize
    @kszer = 100
	@szer = kszer*8
	@wys = kszer*8
    super(szer, wys, false)
	@pozycja = Pozycja.new
	@czcionka = Gosu::Font.new(self, Gosu::default_font_name, kszer)
  end
  
  def needs_cursor? #metoda klasowa Gosu::Window
    true
  end
  
  def pobierz_idx
    [mouse_x.to_i/kszer, mouse_y.to_i/kszer].to_idx
  end
  
  def button_down(id)
    close if id == Gosu::KbQ
	@poczatek = pobierz_idx if id == Gosu::MsLeft
  end
  
  def button_up(id)
    if id == Gosu::MsLeft
	  @cel = pobierz_idx
	  if pozycja.dozwolone_ruchy.include?([poczatek, cel])
	    pozycja.ruch(poczatek, cel)
		@gracz = :komputer_czekaj
	  end
    end
  end
  
  def update #wywoływana automatycznie co kilka sekund
    case gracz
	when :komputer_czekaj then @gracz = :komputer
	when :komputer then
      if !pozycja.koniec?
	    puts "Komputer..."
	    dobry = pozycja.dobry_ruch
	    pozycja.ruch(*dobry)
        puts "wykonano"
	  end
	  @gracz = :czlowiek
	end
  end
  
  def draw
    x, y = 0, 0
	jasny = Gosu::Color::argb(0xff, 0xc0, 0xc0, 0xc0) #alpha red green blue
	ciemny = Gosu::Color::argb(0xff, 0x50, 0x60, 0x30)
	(0..7).each do |i|
	  (0..7).each do |j|
	    kolor = (i+j)%2 == 0 ? jasny : ciemny
		x = i*kszer
		y = j*kszer
	    draw_quad(x,y,kolor, x+kszer, y, kolor, x+kszer, y+kszer, kolor, x, y+kszer, kolor)
		bierka = pozycja.plansza[[i, j].to_idx]
		str = BIERKI[bierka] || ""
		kx = (kszer - czcionka.text_width(str))/2 #środek komórki wg x
		czcionka.draw(str, x+kx, y, 1, 1, 1, Gosu::Color::BLACK)
	  end
	end
    
  end
end

szachy = Szachy.new
szachy.show

