require 'pozycja'

describe Pozycja do 
  its(:plansza) { should == %w(-)*9 }
  its(:tura) {should == 'x'}
  
  context ".new(plansza, tura)" do
    subject {Pozycja.new(%w(x - - - - - - - -), 'o')}
	its(:plansza) {should == %w(x - - - - - - - -)}
	its(:tura) {should == 'o'}
  end
  
  context "#ruch" do
    subject {Pozycja.new.ruch(0)}
	its(:plansza) {should == %w(x - - - - - - - -)}
	its(:tura) {should == 'o'}
  end
  
  context "#dozwolone_ruchy" do
    subject {Pozycja.new.ruch(0).ruch(1)}
	its(:dozwolone_ruchy) {should == [2,3,4,5,6,7,8]}
  end
  
  context "#wygrana?" do
    it {expect(Pozycja.new.wygrana?("x")).to be_false}
	it {expect(Pozycja.new(%w(x x x
										   - - -
										   - - - )).wygrana?("x")).to be_true}
	it {expect(Pozycja.new(%w(- - -
										   x x x
										   - - - )).wygrana?("x")).to be_true}
	it {expect(Pozycja.new(%w(- - -
										   - - -
										   x x x )).wygrana?("x")).to be_true}
	it {expect(Pozycja.new(%w(o - -
										   o - -
										   o - - )).wygrana?("o")).to be_true}
	it {expect(Pozycja.new(%w(- o -
										   - o -
										   - o - )).wygrana?("o")).to be_true}
	it {expect(Pozycja.new(%w(- - o
										   - - o
										   - - o )).wygrana?("o")).to be_true}
	it {expect(Pozycja.new(%w(o - -
										   - o -
										   - - o )).wygrana?("o")).to be_true}
	it {expect(Pozycja.new(%w(- - o
										   - o -
										   o - - )).wygrana?("o")).to be_true}									  
										   
  end
  
  context "#minimax" do
    it {expect(Pozycja.new(%w(x x x - - - - - -), 'x').minimax).to eq(100)}
	it {expect(Pozycja.new(%w(o o o - - - - - -), 'o').minimax).to eq(-100)}
	it {expect(Pozycja.new(%w(x o x x o x o x o), 'x').minimax).to eq(0)}
	it {expect(Pozycja.new(%w(x x - - - - - - -), 'x').minimax).to eq(99)}
	it {expect(Pozycja.new(%w(o o - - - - - - -), 'o').minimax).to eq(-99)}
	it {expect {sleep(2) {Pozycja.new.minimax}}.not_to raise_error}
  end
  
  context "#dobry_ruch" do
    it {expect(Pozycja.new(%w(x x - - - - - - -), 'x').dobry_ruch).to eq(2)}
	it {expect(Pozycja.new(%w(o o - - - - - - -), 'o').dobry_ruch).to eq(2)}
	it {expect(Pozycja.new(%w(o - o - - - - - -), 'o').dobry_ruch).to eq(1)}
  end
end