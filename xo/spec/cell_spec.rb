require "spec_helper"
 
module Xo
  describe Komorka do
    context "#initialize" do
      it "jest domyslnie inicjowana z wartością''" do
        komorka = Komorka.new
        expect(komorka.wartosc).to eq ""
      end
	  it "moze byc zainicjowana z wartoscia'X'" do
        komorka = Komorka.new("X")
        expect(komorka.wartosc).to eq "X"
      end
    end
  end
end