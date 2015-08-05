module Xo
  class Gra
    attr_reader :gracze, :plansza, :obecny_gracz, :drugi_gracz
    
	def initialize(gracze, plansza = Plansza.new)
      @gracze = gracze
      @plansza = plansza
      @obecny_gracz, @drugi_gracz = gracze.shuffle
    end
	
	def zamien_graczy
      @obecny_gracz, @drugi_gracz = @drugi_gracz, @obecny_gracz
    end
	
	def ruch_gracza
      "#{obecny_gracz.imie}: Aby wykonac ruch wprowadz numer pola (1-9)"
    end
	
	def zapisz_ruch(ruch_gracza = gets.chomp)
      koordynaty_ruchu_gracza(ruch_gracza)
    end
	
	def game_over_wiadomosc
      return "\n#{obecny_gracz.imie} wygral!" if plansza.game_over == :wygrany
      return "\nGra zakonczona remisem" if plansza.game_over == :remis
    end
	
	def graj
    puts "#{obecny_gracz.imie} zostal losowo wybrany jako rozpoczynajacy\n"
    while true
      plansza.sformatowana_siatka
      puts ""
      puts ruch_gracza
      x, y = zapisz_ruch
      plansza.ustaw_komorke(x, y, obecny_gracz.kolor)
      if plansza.game_over
        puts game_over_wiadomosc
        plansza.sformatowana_siatka
        return
      else
        zamien_graczy
      end
    end
  end
	
	private
	
	def koordynaty_ruchu_gracza(ruch_gracza)
      mapowanie = {
        "1" => [0, 0],
        "2" => [1, 0],
        "3" => [2, 0],
        "4" => [0, 1],
        "5" => [1, 1],
        "6" => [2, 1],
        "7" => [0, 2],
        "8" => [1, 2],
        "9" => [2, 2]
      }
      mapowanie[ruch_gracza]
    end
  end
end