require "spec_helper"
 
module Xo
  describe Plansza do
  
  Testkomorka = Struct.new(:wartosc)
  let(:x_komorka) { Testkomorka.new("X") }
  let(:y_komorka) { Testkomorka.new("Y") }
  let(:pusty) { Testkomorka.new }
  
    context "#initialize" do
      it "inicjuje plansze z siatka" do
        expect { Plansza.new(siatka: "siatka") }.to_not raise_error
      end
	end
	
	context "#domyslna_siatka" do  
	  it "inicjuje domyslna siatke z trzema wierszami" do
        plansza = Plansza.new
        expect(plansza.siatka).to have(3).things
      end
 
      it "tworzy domyslnie trzy obiekty w kazdym wierszu" do
        plansza = Plansza.new
        plansza.siatka.each do |wiersz|
          expect(wiersz).to have(3).things
		end
      end
    end
    
	context "#siatka" do
      it "zwraca siatke" do
        plansza = Plansza.new(siatka: "pfff")
        expect(plansza.siatka).to eq "pfff"
      end
    end
	
	context "#pobierz_komorke" do
      it "zwraca komorke na podstawie koordynatow (x,y)" do
        siatka = [["", "", ""], ["", "", "cokolwiek"], ["", "", ""]]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.pobierz_komorke(2, 1)).to eq "cos zupelnie nieprzewidzianego"
      end
    end
    
	context "#ustaw_komorke" do
      it "poprawia wartosc komorki na (x,y) koordynacie" do
        Krowa = Struct.new(:wartosc)
        siatka = [[Krowa.new("swietnie"), "", ""], ["", "", ""], ["", "", ""]]
        plansza = Plansza.new(siatka: siatka)
        plansza.ustaw_komorke(0, 0, "muu")
        expect(plansza.pobierz_komorke(0, 0).wartosc).to eq "muu"
      end
    end
	
	context "#game_over" do
      it "zwraca :wygrany, jezeli wygrany? true" do
        plansza = Plansza.new
        plansza.stub(:wygrany?) { true }
        expect(plansza.game_over).to eq :wygrany
      end
 
      it "zwraca :remis jezeli wygrany? false i remis? true" do
        plansza = Plansza.new
        plansza.stub(:wygrany?) { false }
        plansza.stub(:remis?) { true }
        expect(plansza.game_over).to eq :remis
      end
 
      it "zwraca false jezeli wygrany? false i remis? false" do
        plansza = Plansza.new
        plansza.stub(:wygrany?) { false }
        plansza.stub(:remis?) { false }
        expect(plansza.game_over).to be_false
      end
	  
	  it "zwraca :wygrany kiedy wiersz zawiera takie same wartosci" do
        siatka = [
          [x_komorka, x_komorka, x_komorka],
          [y_komorka, x_komorka, y_komorka],
          [y_komorka, y_komorka, pusty]
        ]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.game_over).to eq :wygrany
      end
 
      it "zwraca :wygrany kiedy kolumna zawiera takie same wartosci" do
        siatka = [
          [x_komorka, x_komorka, pusty],
          [y_komorka, x_komorka, y_komorka],
          [y_komorka, x_komorka, pusty]
        ]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.game_over).to eq :wygrany
      end
   
      it "zwraca :wygrany kiedy przekatna zawiera takie same obiekty" do
        siatka = [
          [x_komorka, pusty, pusty],
          [y_komorka, x_komorka, y_komorka],
          [y_komorka, x_komorka, x_komorka]
        ]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.game_over).to eq :wygrany
      end
 
      it "zwraca :remis kiedy wszystkie komorki sa zajete" do
        siatka = [
          [x_komorka, y_komorka, x_komorka],
          [y_komorka, x_komorka, y_komorka],
          [y_komorka, x_komorka, y_komorka]
        ]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.game_over).to eq :remis
      end
   
      it "zwraca false gdy :wygrany i :remis false" do
        siatka = [
          [x_komorka, pusty, pusty],
          [y_komorka, pusty, pusty],
          [y_komorka, pusty, pusty]
        ]
        plansza = Plansza.new(siatka: siatka)
        expect(plansza.game_over).to be_false
      end
    end
  end
end