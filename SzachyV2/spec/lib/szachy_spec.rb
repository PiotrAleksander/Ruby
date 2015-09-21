require 'szachy'
require 'ruby-prof'
include SzachyHelper

describe SzachyHelper do
  context "numer" do
    it {expect(a8).to eq 21}
	it {expect(h8).to eq 28}
	it {expect(a1).to eq 91}
	it {expect(h1).to eq 98}
  end
end

describe String do
  context "to_idx" do
    it {expect("a8".to_idx).to eq 21}
	it {expect("h8".to_idx).to eq 28}
	it {expect("a1".to_idx).to eq 91}
	it {expect("h1".to_idx).to eq 98}
  end
end

describe Array do
  context "to_idx" do
    it {expect([0, 0].to_idx).to eq a8}
	it {expect([1, 0].to_idx).to eq b8}
	it {expect([0, 1].to_idx).to eq a7}
  end
end

describe Fixnum do
  context "to_pole" do
    it {expect(21.to_pole).to eq "a8"}
	it {expect(28.to_pole).to eq "h8"}
	it {expect(91.to_pole).to eq "a1"}
	it {expect(98.to_pole).to eq "h1"}
  end
end

describe Pozycja do
  context ".new" do
    it {expect(subject.plansza[e4]).to eq nil}
	it {expect(subject.plansza[e2]).to eq :P}
    it {expect(subject.plansza[d1]).to eq :H}
	it {expect(subject.plansza[d8]).to eq :h}
	its(:tura) {should == :biale}
	its(:roszada) {should == "KHkh"}
	its(:ep) {should == nil}
	its(:polruch) {should == 0}
	its(:pelenruch) {should == 1}
	its(:krol) {should == {biale: e1, czarne: e8 }}
  end
  context ".[]" do
    it {expect(Pozycja[W: e4]).to eq Pozycja[W: e4]}
	it {expect(Pozycja[W: e4].plansza[e4]).to eq :W}
	it {expect(Pozycja[W: [e2, e4]].plansza[e2]).to eq :W}
	it {expect(Pozycja[W: [e2, e4]].plansza[e4]).to eq :W}
	it {expect(Pozycja[K: e1, W: h1]).to eq Pozycja[K: e1, W: h1, :roszada => "K"]}
  end
  context "#ruch" do
    context "e4" do
	  subject {Pozycja.new.ruch("e4")}
	  it {expect(subject.plansza[e4]).to eq :P}
	  it {expect(subject.plansza[e2]).to eq nil}
	  its(:tura) {should == :czarne}
	  its(:roszada) {should == "KHkh"}
	  its(:ep) {should == e3}
	  its(:polruch) {should == 0}
	  its(:pelenruch) {should == 1}
	end
	context "e4 e5" do
	  subject {Pozycja.new.ruch("e4").ruch("e5")}
	  it {expect(subject.plansza[e5]).to eq :p}
	  it {expect(subject.plansza[e7]).to eq nil}
	  its(:tura) {should == :biale}
	  its(:roszada) {should == "KHkh"}
	  its(:ep) {should == e6}
	  its(:polruch) {should == 0}
	  its(:pelenruch) {should == 2}
	end
	context "e4 e5 Sf3" do
	  subject {Pozycja.new.ruch("e4").ruch("e5").ruch("Sf3")}
	  it {expect(subject.plansza[f3]).to eq :S}
	  it {expect(subject.plansza[g1]).to eq nil}
	  its(:tura) {should == :czarne}
	  its(:roszada) {should == "KHkh"}
	  its(:ep) {should == nil}
	  its(:polruch) {should == 1}
	  its(:pelenruch) {should == 2}
	end
	context "e4 e5 Sf3 Sf6" do
	  subject {Pozycja.new.ruch("e4").ruch("e5").ruch("Sf3").ruch("Sf6")}
	  it {expect(subject.plansza[f6]).to eq :s}
	  it {expect(subject.plansza[g8]).to eq nil}
	  its(:tura) {should == :biale}
	  its(:roszada) {should == "KHkh"}
	  its(:ep) {should == nil}
	  its(:polruch) {should == 2}
	  its(:pelenruch) {should == 3}
	end
	context "e4 e5 Sf3 Sf6 Sxe5" do
	  subject {Pozycja.new.ruch("e4").ruch("e5").ruch("Sf3").ruch("Sf6").ruch("Sxe5")}
	  it {expect(subject.plansza[e5]).to eq :S}
	  it {expect(subject.plansza[f3]).to eq nil}
	  its(:tura) {should == :czarne}
	  its(:roszada) {should == "KHkh"}
	  its(:ep) {should == nil}
	  its(:polruch) {should == 0}
	  its(:pelenruch) {should == 3}
	end
	
	context "poprawne ruchy z pgn" do
	  it {
	    #RubyProf.start
	    File.open("gry/Morphy.pgn", "r") do |p|
		  pozycja = Pozycja.new
		  gra = 1
		  while wiersz = p.gets
		    next if wiersz.start_with?("[")
		    wiersz.gsub(/\b\d+\./,"").split.each do |str|
			  case str
			  when %r"^1-0$|^0-1$|^1/2-1/2$|^\*$" then
			    pozycja = Pozycja.new
				gra += 1
			  else
			  pozycja.ruch(str)
			  #puts "", "Gra #{gra}", pozycja, str
			  end
			end
		  end
		end
		#RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT)
	  }
	end
    context "dwa argumenty" do
      it {expect(Pozycja[W: e2].ruch(e2, e4)).to eq \
		Pozycja[W: e4, tura: :czarne, polruch: 1]}
	  it "usuwa roszadę po ruchu króla" do 
	    expect(Pozycja[K: e1, W: [a1, h1]].ruch(e1, e2)).to eq \
		Pozycja[K: e2, W: [a1, h1], roszada: "", tura: :czarne, polruch: 1]
	  end
	  it "roszada krótka" do
	    expect(Pozycja[K: e1, W: h1].ruch(e1, g1)).to eq \
			Pozycja[K: g1, W: f1, roszada: "", tura: :czarne, polruch: 1]
	  end
	  it "roszada długa" do
	    expect(Pozycja[K: e1, W: a1].ruch(e1, c1)).to eq \
			Pozycja[K: c1, W: d1, roszada: "", tura: :czarne, polruch: 1]
	  end
	  it "en passant" do
	    expect(Pozycja[P: e5, p: f5, ep: f6].ruch(e5, f6)).to eq Pozycja[P: f6, tura: :czarne, ]
	  end
    end
	context "promocja piona" do
	  it {expect(Pozycja[P: e7].ruch(e7, e8, :H)).to eq Pozycja[H: e8, tura: :czarne]}
	end
  end
  context "#ruch_str" do
    it {expect(Pozycja[W: e4].ruch_str(e4, e2)).to eq "We2"}
	it {expect(Pozycja[W: [e4, e2]].ruch_str(e4, e3)).to eq "W4e3"}
	it {expect(Pozycja[W: [e4, a4]].ruch_str(e4, b4)).to eq "Web4"}
	it {expect(Pozycja[G: [d3, d5, f3, f5]].ruch_str(d3, e4)).to eq "Gd3e4"}
	it {expect(Pozycja[P: e2].ruch_str(e2, e4)).to eq "e4"}
	it {expect(Pozycja[P: e2, p: d3].ruch_str(e2, d3)).to eq "ed"}
	it {expect(Pozycja[P: [e2, e3], p: [d3, d4]].ruch_str(e2, d3)).to eq "ed3"}
	it {expect(Pozycja[P: [e2, g2], p: [f3]].ruch_str(e2, f3)).to eq "ef"}
	it {expect(Pozycja[K: e1].ruch_str(e1, e2)).to eq "Ke2"}
	it {expect(Pozycja[K: e1, W: h1].ruch_str(e1, g1)).to eq "O-O"}
	it {expect(Pozycja[K: e1, W: a1].ruch_str(e1, c1)).to eq "O-O-O"}
  end
  context "#dozwolone_ruchy" do
	it "Rozpoznaje rzeczywisty zasięg Wieży" do
	  expect(Pozycja[W: e4].dozwolone_ruchy_str).to eq \
	  ["Wa4", "Wb4", "Wc4", "Wd4", "We8", "We7", "We6", "We5", "We3", "We2", "We1", "Wf4", "Wg4", "Wh4"]
	end
	it "Rozpoznaje rzeczywisty zasięg Gońca" do 
	  expect(Pozycja[G: e4].dozwolone_ruchy_str).to eq \
      ["Ga8", "Gb7", "Gb1", "Gc6", "Gc2", "Gd5", "Gd3", "Gf5", "Gf3", "Gg6", "Gg2", "Gh7", "Gh1"]
    end	  
	it "Rozpoznaje rzeczywisty zasięg Skoczka" do 
	  expect(Pozycja[S: e4].dozwolone_ruchy_str).to eq \
	  ["Sc5", "Sc3", "Sd6", "Sd2", "Sf6", "Sf2", "Sg5", "Sg3"]
	end
	it "Rozpoznaje rzeczywisty zasięg Króla i krótką roszadę" do
	  expect(Pozycja[K: e1, W: h1].dozwolone_ruchy_str.sort).to eq \
	  ["Kd1", "Kd2", "Ke2", "Kf1", "Kf2", "O-O", "Wf1", "Wg1", "Wh2", "Wh3", "Wh4", "Wh5", "Wh6", "Wh7", "Wh8"]
	end
	it "Rozpoznaje rzeczywisty zasięg Króla i długą roszadę" do 
	  expect(Pozycja[K: e1, W: a1].dozwolone_ruchy_str.sort).to eq \
	  ["Kd1", "Kd2", "Ke2", "Kf1", "Kf2", "O-O-O", "Wa2", "Wa3", "Wa4", "Wa5", "Wa6", "Wa7", "Wa8", "Wb1", "Wc1", "Wd1"]
	end
	it "Dozwala kaptażowi bierek" do
	  expect(Pozycja[W: e4, w: e6].dozwolone_ruchy_str.sort).to eq ["Wa4", "Wb4", "Wc4", "Wd4", "We1", "We2", "We3", "We5", "We6", "Wf4", "Wg4", "Wh4"]
	end
	it "Dozwala ruchom Hetmana" do
	  expect(Pozycja[h: e4, :tura => :czarne].dozwolone_ruchy_str.sort).to eq \
	  ["Ha4", "Ha8", "Hb1", "Hb4", "Hb7", "Hc2", "Hc4", "Hc6", "Hd3", "Hd4", "Hd5", "He1","He2", 
	  "He3", "He5", "He6", "He7", "He8", "Hf3", "Hf4", "Hf5", "Hg2", "Hg4", "Hg6", "Hh1", "Hh4","Hh7"]
	end
	it "Nie dozwala roszadzie z szachowanej pozycji" do
	  expect(Pozycja[K: e1, W: h1, w: e8].dozwolone_ruchy_str.sort).not_to include "O-O"
	end
	it "Nie dozwala pozostawianiu Króla w szachu" do
	  expect(Pozycja[K: e1, W: h1, w: e8].dozwolone_ruchy_str.sort).not_to include "Wh2"
	end
	it "Nie dozwala roszadzie poprzez szachowaną pozycję" do
	  expect(Pozycja[K: e1, W: h1, w: f8].dozwolone_ruchy_str.sort).not_to include "O-O"
	end
	it "Nie dozwala roszady poprzez obsadzoną linię" do
      expect(Pozycja[k: e8, w: a8, G: b8, tura: :czarne].dozwolone_ruchy_str.sort).not_to include "O-O-O"	
	end
	it "Dozwala ruchom Piona" do
	  expect(Pozycja[P:e3].dozwolone_ruchy_str.sort).to eq ["e4"]
	  expect(Pozycja[P:e2].dozwolone_ruchy_str.sort).to eq ["e3","e4"]
	  expect(Pozycja[P:e3, p: e4].dozwolone_ruchy_str.sort).to eq []
	  expect(Pozycja[P:e2, p: e3].dozwolone_ruchy_str).to eq []
	end
	it "Dozwala kaptażom Piona" do
	  expect(Pozycja[P: e2, p: d3].dozwolone_ruchy_str.sort).to include "ed" 
	end
	it "Dozwala kaptażom en passant" do
	  expect(Pozycja[P: e5, p: d5, ep: d6].dozwolone_ruchy_str.sort).to eq ["e6", "ed"] 
	end
	it "Dozwala promocji Piona" do
	  expect(Pozycja[P: e7].dozwolone_ruchy_str.sort).to eq ["e8=G", "e8=H", "e8=S", "e8=W"]
	end
	it "Dozwala promocji Piona kaptażującemu" do
	  expect(Pozycja[P: e7, p: d8].dozwolone_ruchy_str.sort).to eq \
	  ["e8=G", "e8=H", "e8=S", "e8=W", "ed=G", "ed=H", "ed=S", "ed=W"]
	end
  end
  context "#mat?" do
    it {expect(Pozycja.new.mat?).to eq false}
	it {expect(Pozycja[K: e1, h: e2, k: e3].mat?).to eq true}
	it {expect(Pozycja[K: e1, h: e2, k: e8].mat?).to eq false}
  end
  context "#pat?" do
    it {expect(Pozycja.new.pat?).to eq false}
	it {expect(Pozycja[K: e1, p: e2, k: e3].pat?).to eq true}
	it {expect(Pozycja[K: e1, p: e2, k: e8].pat?).to eq false}
  end
  context "#remis?" do
    it {expect(Pozycja.new.remis?).to eq false}
	it {expect(Pozycja[K: e1, h: e2, k: e8].remis?).to eq false}
	it {expect(Pozycja[K: e1, p: e2, k: e3, polruch: 101].remis?).to eq true}
	it {expect(Pozycja[K: e1, h: e2, k: e3, polruch: 101].remis?).to eq false}
  end
  context "#minimax" do
    it {expect(Pozycja[K: e1, h: e2, k: e3].minimax).to eq (-100)}
	it {expect(Pozycja[k: e1, H: e2, K: e3, tura: :czarne].minimax).to eq 100}
	it {expect(Pozycja[K: e1, p: e2, k: e3].minimax).to eq 0}
	it {expect(Pozycja[k: e1, H: d3, K: e3, tura: :biale].minimax).to eq 99}
	it {expect(Pozycja[K: e1, h: d3, k: e3, tura: :czarne].minimax).to eq (-99)}
  end
  context "#dobry_ruch" do
    it {expect(Pozycja[K: e1, h: d3, k: e3, g: b1, tura: :czarne].dobry_ruch).to eq [d3, e2]}
  end
  context "koniec gry" do
    it {expect(Pozycja[K: e1, p: e2, k: e3].koniec?).to eq true}
    it {expect(Pozycja.new.koniec?).to eq false}
    it {expect(Pozycja[k: e1, H: e2, K: e3, tura: :czarne].koniec?).to eq true}
  end
end