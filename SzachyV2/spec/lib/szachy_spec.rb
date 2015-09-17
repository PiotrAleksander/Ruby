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
    context "#dwa argumenty" do
      it {expect(Pozycja[W: e2].ruch(e2, e4)).to eq Pozycja[W: e4, tura: :czarne, polruch: 1]}
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
	it {expect(Pozycja[W: e4].dozwolone_ruchy_str).to eq \
	  ["Wa4", "Wb4", "Wc4", "Wd4", "We8", "We7", "We6", "We5", "We3", "We2", "We1", "Wf4", "Wg4", "Wh4"] }
	it {expect(Pozycja[G: e4].dozwolone_ruchy_str).to eq \
      ["Ga8", "Gb7", "Gb1", "Gc6", "Gc2", "Gd5", "Gd3", "Gf5", "Gf3", "Gg6", "Gg2", "Gh7", "Gh1"]}	
	it {expect(Pozycja[S: e4].dozwolone_ruchy_str).to eq \
	  ["Sc5", "Sc3", "Sd6", "Sd2", "Sf6", "Sf2", "Sg5", "Sg3"]}
	it {expect(Pozycja[K: e1, W: h1].dozwolone_ruchy_str.sort).to eq \
	["Kd1", "Kd2", "Ke2", "Kf1", "Kf2", "O-O", "Wf1", "Wg1", "Wh2", "Wh3", "Wh4", "Wh5", "Wh6", "Wh7", "Wh8"]}
	it {expect(Pozycja[K: e1, W: a1].dozwolone_ruchy_str.sort).to eq \
	["Kd1", "Kd2", "Ke2", "Kf1", "Kf2", "O-O-O", "Wa2", "Wa3", "Wa4", "Wa5", "Wa6", "Wa7", "Wa8", "Wb1", "Wc1", "Wd1"]}
  end
end