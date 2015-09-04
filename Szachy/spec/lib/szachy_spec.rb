require 'szachy'

include SzachyHelper

describe SzachyHelper do
  context "to_idx" do
    it {expect(to_idx(0)).to eq 0}
	it {expect(to_idx(:a8)).to eq 0}
	it {expect(to_idx(:h8)).to eq 7}
	it {expect(to_idx(:h1)).to eq 63}
  end
  
  context "kolor" do
    it {expect(kolor("P")).to eq :biale}
	it {expect(kolor("p")).to eq :czarne}
	it {expect(kolor("-")).to be_nil}
  end
  
  context "xydiff" do
    it {expect(xydiff(0,1)).to eq [1,0]}
	it {expect(xydiff(0,8)).to eq [0,1]}
  end
  
  context "to_pole" do
    it {expect(to_pole(:e4)).to eq :e4}
	it {expect(to_pole("e4")).to eq :e4}
	it {expect(to_pole(to_idx(:f4))).to eq :f4}
  end
  
  context "to_kol" do
    it {expect(to_kol("a")).to eq 0}
	it {expect(to_kol("b")).to eq 1}
	it {expect(to_kol(0)).to eq 0}
	it {expect(to_kol(1)).to eq 1}
	it {expect(to_kol(8)).to eq 0}
  end
  
  context "to_wiersz" do
    it {expect(to_wiersz("1")).to eq 7}
	it {expect(to_wiersz("2")).to eq 6}
	it {expect(to_wiersz(0)).to eq 0}
	it {expect(to_wiersz(1)).to eq 0}
	it {expect(to_wiersz(8)).to eq 1}
  end
end

describe Pozycja do
  its(:plansza) {should == %w(-)*64}
  its(:tura) {should == :biale}
  its(:ep) {should be_nil}
  its(:roszada) {should == %w(K H k h)}
  its(:polruch) {should == 0}
  its(:pelenruch) {should == 1}
  context ".new(agrs)" do
    it {expect(Pozycja.new(:czarne).tura).to eq :czarne}
	it {expect(Pozycja.new(:tura => :czarne).tura).to eq :czarne}
  end
  
  context ".[]" do
    subject {Pozycja["We4 .. Ge1 e2", :czarne] }
	it {expect(subject[:e4]).to eq "W"}
	it {expect(subject[:e1]).to eq "g"}
	it {expect(subject[:e2]).to eq "p"}
	its(:tura) {should == :czarne}
  end
  
  context "droga_wolna" do
    it {expect(Pozycja["We4"].droga_wolna(to_idx(:e4), to_idx(:e2))).to be_true}
	it {expect(Pozycja["We4 e3"].droga_wolna(to_idx(:e4), to_idx(:e2))).to be_false}
	it {expect(Pozycja["We4 e2"].droga_wolna(to_idx(:e4), to_idx(:e2))).to be_true}
  end
  
  context "#znajdz" do
	it {expect(Pozycja["We4"].znajdz("W", :e2)).to eq [:e4]}
    it {expect(Pozycja["We4 e3"].znajdz("W", :e2)).to eq []}
	it {expect(Pozycja["We4 We1"].znajdz("W", :e2)).to eq [:e4, :e1]}
	it {expect(Pozycja["We4 Wd1"].znajdz("W", :e2)).to eq [:e4]}
	it {expect(Pozycja["We4 e2"]. znajdz("W", :e2)).to eq []}
	it {expect(Pozycja["Se4"]. znajdz("S", :c3)).to eq [:e4]}
	it {expect(Pozycja["Se4"]. znajdz("S", :e2)).to eq []}
	it {expect(Pozycja["Se4 d3 d4 d5"]. znajdz("S", :c3)).to eq [:e4]}
	it {expect(Pozycja[".. Ge4, :czarne"]. znajdz("g", :f3)).to eq [:e4]}
	it {expect(Pozycja[".. Ge4, :czarne"]. znajdz("g", :f4)).to eq []}
	it {expect(Pozycja["He4"]. znajdz("H", :e2)).to eq [:e4]}
	it {expect(Pozycja["He4"]. znajdz("H", :a8)).to eq [:e4]}
	it {expect(Pozycja["He4"]. znajdz("H", :c3)).to eq []}
	it {expect(Pozycja["Ke4"]. znajdz("K", :e3)).to eq [:e4]}
	it {expect(Pozycja["Ke4"]. znajdz("K", :e2)).to eq []}
	it {expect(Pozycja["e2"].znajdz("P", :e3)).to eq [:e2]}
	it {expect(Pozycja["e2"].znajdz("P", :e4)).to eq [:e2]}
	it {expect(Pozycja["e2"].znajdz("P", :e5)).to eq []}
	it {expect(Pozycja["e2 .. e3"].znajdz("P", :e3)).to eq []}
	it {expect(Pozycja["e2 .. f3"].znajdz("P", :f3)).to eq [:e2]}
	it {expect(Pozycja["e3"].znajdz("P", :e5)).to eq []}
	it {expect(Pozycja["e5 .. f5", :ep => :f6].znajdz("P", :f6)).to eq [:e5]}
	it {expect(Pozycja["e4 .. g6"].znajdz("P", :g6)).to eq []}
	it {expect(Pozycja["e4 .. g6"].znajdz("p", :g5)).to eq [:g6]}
  end
  
  context "#dup" do
    let(:pozycja) {Pozycja.new}
    subject {pozycja.dup}
	it {
	  subject[:e4] = "W"
	  expect(pozycja[:e4]).to eq "-"
	}
  end
  
  context ".setup" do
    subject { Pozycja.setup }
	it {expect(subject.plansza[to_idx(:a1)..to_idx(:h1)]).to eq %w(W S G H K G S W)}
	its(:tura) {should == :biale}
  end
  
  context "#szach?" do
    it {expect(Pozycja.setup.szach?).to be_false}
	it {expect(Pozycja["Ke4 .. f5"].szach?).to be_true}
	it {expect(Pozycja.new.szach?).to be_false}
  end
  
  context "#poprzez_szach?" do
    it {expect(Pozycja[".. We4"].poprzez_szach?(:e2)).to be_true }
	it {expect(Pozycja["We4"].poprzez_szach?(:e2)).to be_false}
  end
  
  context "#ruch" do
    context "1. e4" do 
      subject {Pozycja.setup.
					ruch("e4")}
	  its(:tura) {should == :czarne}
	  it {expect(subject[:e4]).to eq "P"}
	  it {expect(subject[:e2]).to eq "-"}
	  its(:pelenruch) {should == 1}
	  its(:polruch) {should == 0}
	  its(:ep) {should == :e3}
    end
	
	context "1. e4 e5" do
	  subject {Pozycja.setup.
				ruch("e4").ruch("e5")}
	  its(:tura) {should == :biale}
	  it {expect(subject[:e5]).to eq "p"}
	  it {expect(subject[:e7]).to eq "-"}
	  its(:pelenruch) {should == 2}
	  its(:polruch) {should == 0}
	  its(:ep) {should == :e6}
	end
	
	context "1. e4 e5 2. Sf3" do
	  subject {Pozycja.setup.
					ruch("e4").ruch("e5").
					ruch("Sf3")
					}
	  its(:tura) {should == :czarne}
	  it {expect(subject[:f3]).to eq "S"}
	  it {expect(subject[:g1]).to eq "-"}
	  its(:pelenruch) {should == 2}
	  its(:polruch) {should == 1}
	  its(:ep) {should be_nil}
	end
	
	context "1. e4 e5 2. Sf3" do
	  subject {Pozycja.setup.
					ruch("e4").ruch("e5").
					ruch("Sf3").ruch("Sc6")
					}
	  its(:tura) {should == :biale}
	  it {expect(subject[:c6]).to eq "s"}
	  it {expect(subject[:b8]).to eq "-"}
	  its(:pelenruch) {should == 3}
	  its(:polruch) {should == 2}
	  its(:ep) {should be_nil}
	end
	
	context "roszada" do
	  subject { Pozycja["Ke1 Wh1"].ruch("O-O")}
	  its(:roszada) {should == %w(H k h)}
	end
	
	context "en-passant" do
	  subject {Pozycja["e5 .. f5", :ep => :f6].ruch("exf6")}
	  it {expect(subject[:f6]).to eq "P"}
	  it {expect(subject[:f5]).to eq "-"}
	end
	
	context "en-passant pionkiem" do
	  subject {Pozycja["He5 .. f5", :ep => :f6].ruch("Hf6")}
	  it {expect(subject[:f5]).to eq "p"}
	end

	context "wykonuj poprawne ruchy z pgn" do
	  it {
	        pozycja = Pozycja.setup
			licznik = 0
			File.open("gry/Morphy.pgn", "r") do |f|
			  while linia = f.gets
			    next if linia.start_with? ("[")
				linia.gsub(/\b\d+\./, "").split.each do |m|
				  if m =~ %r"^(1-0|0-1|1/2-1/2)$"
				    pozycja = Pozycja.setup
					licznik += 1
				  else
				    gets.chomp
				    pozycja = pozycja.ruch(m)
				    puts
				    puts "Gra: #{licznik}"
				    puts pozycja
				    puts m
				  end
				end
			  end
			end  
	  }
	end
	context "Roszada nie może przechodzić przez szachowane pole, ani nie może na takim polu zostać zakończona " do
	  subject {Pozycja.new(:plansza => %w(- - - - - - - -
	                                                         - - - - - - - -
															 - - - - - - - -
															 - - - - - - - -
															 - - - - - - - -
															 - - - g - - - -
															 - - - - - - - -
															 - - - - K - - W))}
	  it {expect{subject.ruch("O-O")}.to raise_error}
	end
  end
end