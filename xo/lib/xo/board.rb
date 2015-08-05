module Xo
  class Plansza
    attr_reader :siatka
    
	def initialize(wejscie = {})
      @siatka = wejscie.fetch(:siatka, domyslna_siatka)
    end
	
	def pobierz_komorke(x, y)
      siatka[y][x]
    end
	
	def ustaw_komorke(x, y, wartosc)
      pobierz_komorke(x, y).wartosc = wartosc
    end
	
	def game_over
      return :wygrany if wygrany?
      return :remis if remis?
      false
    end

    def remis?
      siatka.flatten.map { |komorka| komorka.wartosc }.zaden_pusty?
    end	
	
	def sformatowana_siatka
      siatka.each do |wiersz|
        puts wiersz.map { |komorka| komorka.wartosc.empty? ? "_" : komorka.wartosc }.join(" ")
      end
    end
	
	private
	
	def pozycje_wygrywajace
      siatka + # wiersze
      siatka.transpose + # kolumny
      przekatne # dwie przekatne
    end
 
    def przekatne
      [
        [pobierz_komorke(0, 0), pobierz_komorke(1, 1), pobierz_komorke(2, 2)],
        [pobierz_komorke(0, 2), pobierz_komorke(1, 1), pobierz_komorke(2, 0)]
      ]
    end
	
	def wygrany?
      pozycje_wygrywajace.each do |wygrywajace_pozycje|
        next if wartosc_wygrywajacych_pozycji(wygrywajace_pozycje).wszystkie_puste?
        return true if wartosc_wygrywajacych_pozycji(wygrywajace_pozycje).takie_same?
      end
      false
    end
 
    def wartosc_wygrywajacych_pozycji(wygrywajace_pozycje)
      wygrywajace_pozycje.map { |komorka| komorka.wartosc }
    end
	
    def domyslna_siatka
      Array.new(3) { Array.new(3) { Komorka.new } }
    end
  end
end