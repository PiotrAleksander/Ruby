require 'rubygems'
require 'gosu'
require './pozycja.rb'

class Gra < Gosu::Window
  attr_accessor :szer, :szer_kom, :pozycja, :czcionka
  
  def initialize
    @szer = 600
	@szer_kom = @szer/3
	@pozycja = Pozycja.new
	super(szer, szer, false)
	@czcionka = Gosu::Font.new(self, Gosu::default_font_name, szer_kom)
	@czcionkaZ = Gosu::Font.new(self, Gosu::default_font_name, szer_kom/3)
  end
  
  def button_down(id)
    case id
	when Gosu::KbEscape then close
	when Gosu::MsLeft then 
	  @pozycja = @pozycja.ruch((mouse_x/szer_kom).to_i + 3*(mouse_y/szer_kom).to_i)
	  if ! @pozycja.dozwolone_ruchy.empty? then
	    idx = @pozycja.dobry_ruch
		@pozycja =@pozycja.ruch(idx)
	  end
	end
  end
  
  def needs_cursor?
    true
  end
  
  def draw
    #rysuj siatkę
    [szer_kom, szer_kom*2].each do |w|
      draw_line(w, 0, Gosu::Color::WHITE, w, szer, Gosu::Color::WHITE)
	  draw_line(0, w, Gosu::Color::WHITE, szer, w, Gosu::Color::WHITE)
	end
	
	pozycja.plansza.each.with_index do |z, i|
	  if z != "-"
	    x = (i%3)*szer_kom+@czcionka.text_width(z)/2
		y = (i/3)*szer_kom
	    @czcionka.draw(z, x, y, 0)
	  end
	end
	
	zakonczenie("Wygrales!") if @pozycja.wygrana?("x")
	zakonczenie("Wygral komputer.") if @pozycja.wygrana?("o")
	zakonczenie("Remis") if @pozycja.dozwolone_ruchy.empty?
  end
  	def zakonczenie(txt)
	  czarny = Gosu::Color::BLACK
	  draw_quad(0, 100, czarny,
					   szer, 100, czarny,
					   szer, 500, czarny,
					   0, 500, czarny)
	  @czcionkaZ.draw(txt, (szer-@czcionkaZ.text_width(txt))/2, szer/2-100, 0)
	end
end

gra = Gra.new
gra.show
