require "spec_helper"
 
module Xo
  describe Gracz do
    context "#initialize" do
 
      it "podnosi(raise) blad gdy zainicjowana z {}" do
        expect { Gracz.new({}) }.to raise_error
      end
      it "nie podnosi(raise) bledu, gdy zainicjowana z poprawnym slownikiem(hash)" do
        input = { kolor: "X", imie: "Ktos" }
        expect { Gracz.new(input) }.to_not raise_error
      end
    end
	context "#kolor" do
      it "zwraca kolor" do
        input = { kolor: "X", imie: "Ktos" }
        player = Gracz.new(input)
        expect(player.kolor).to eq "X"
      end
    end
 
    context "#imie" do
      it "zwraca imie gracza" do
        input = { kolor: "X", imie: "Ktos" }
        player = Gracz.new(input)
        expect(player.imie).to eq "Ktos"
      end
    end
  end
end