require "spec_helper"

module Xo
  describe Gra do
 
    let (:gracz1) { Gracz.new({kolor: "X", imie: "gracz1"}) }
    let (:gracz2) { Gracz.new({kolor: "O", imie: "gracz2"}) }
 
    context "#initialize" do
      it "losowo wybiera obecnego gracza" do
        Array.any_instance.stub(:shuffle) { [gracz2, gracz1] } #stub wymusza na funkcji w miejsce shuffle wstawienie wartosci deterministycznej
        gra = Gra.new([gracz1, gracz2])
        expect(gra.obecny_gracz).to eq gracz2
      end
 
      it "losowo wybiera drugiego gracza" do
        Array.any_instance.stub(:shuffle) { [gracz2, gracz1] }
        gra = Gra.new([gracz1, gracz2])
        expect(gra.drugi_gracz).to eq gracz1
      end
    end
 
    context "#zamien_graczy" do
      it "ustawi @obecny_gracz jako @drugi_gracz" do
        gra = Gra.new([gracz1, gracz2])
        drugi_gracz = gra.drugi_gracz
        gra.zamien_graczy
        expect(gra.obecny_gracz).to eq drugi_gracz
      end
 
      it "ustawi @drugi_gracz jako @obecny_gracz" do
        gra = Gra.new([gracz1, gracz2])
        obecny_gracz = gra.obecny_gracz
        gra.zamien_graczy
        expect(gra.drugi_gracz).to eq obecny_gracz
      end
    end
	
	context "#ruch_gracza" do
      it "prosi gracza o wykonanie ruchu" do
        gra = Gra.new([gracz1, gracz2])
        gra.stub(:obecny_gracz) { gracz1 }
        expected = "gracz1: Aby wykonac ruch wprowadz numer pola (1-9)"
        expect(gra.ruch_gracza).to eq expected
      end
    end
	
	context "#zapisz_ruch" do
      it "zamienia ruch '1' na [0, 0]" do
        gra = Gra.new([gracz1, gracz2])
        expect(gra.zapisz_ruch("1")).to eq [0, 0]
      end
  
      it "zamienia ruch '7' na [0, 2]" do
        gra = Gra.new([gracz1, gracz2])
        expect(gra.zapisz_ruch("7")).to eq [0, 2]
      end
    end
	
	context "#game_over_wiadomosc" do
      it "zwraca '{obecny_gracz} wygral!' if plansza shows a wygrany" do
        gra = Gra.new([gracz1, gracz2])
        gra.stub(:obecny_gracz) { gracz1 }
        gra.plansza.stub(:game_over) { :wygrany }
        expect(gra.game_over_wiadomosc).to eq "\ngracz1 wygral!"
      end
 
      it "zwraca 'Gra zakonczona remisem', jezeli plansza pokazuje remis" do
        gra = Gra.new([gracz1, gracz2])
        gra.stub(:obecny_gracz) { gracz1 }
        gra.plansza.stub(:game_over) { :remis }
        expect(gra.game_over_wiadomosc).to eq "Gra zakonczona remisem"
      end
    end
  end
end