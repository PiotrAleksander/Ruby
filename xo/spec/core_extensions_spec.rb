require "spec_helper"
 
describe Array do
  context "#wszystkie_puste?" do
    it "zwraca true, jezeli wszystkie elementy tablicy sa puste" do
      expect(["", "", ""].wszystkie_puste?).to be_true
    end
 
    it "zwraca false, jezeli tylko niektore elementy tablicy sa puste" do
      expect(["", 1, "", Object.new, :a].wszystkie_puste?).to be_false
    end
 
    it "zwraca true dla pustej tablicy" do
      expect([].wszystkie_puste?).to be_true
    end
  end
  
  context "#takie_same?" do
    it "zwraca prawde, jezeli wszystkie elementy tablicy sa takie same" do
      expect(["A", "A", "A"].takie_same?).to be_true
    end
 
    it "zwraca false, jezeli elementy tablicy sa rozne" do
      expect(["", 1, "", Object.new, :a].takie_same?).to be_false
    end
 
    it "zwraca prawde dla pustej tablicy" do
      expect([].takie_same?).to be_true
    end
  end
  
  context "#ktorys_pusty?" do
    it "zwraca true, jezeli ktorys z elementow tablicy jest pusty" do
      expect(["", "A", "A"].ktorys_pusty?).to be_true
    end
 
    it "zwraca false, jezeli zaden z elementow tablicy nie jest pusty" do
      expect(["A", 1, Object.new, :a].ktorys_pusty?).to be_false
    end
 
    it "zwraca false dla pustej tablicy" do #nil zwraca false dla metody any?
      expect([].ktorys_pusty?).to be_false
    end
  end
  
  context "#zaden_pusty?" do
    it "zwraca false, jezeli jeden element tablicy jest pusty" do
      expect(["", "A", "A"].zaden_pusty?).to be_false
    end
 
    it "zwraca true, jezeli zaden z elementow nie jest pusty" do
      expect(["A", 1, Object.new, :a].zaden_pusty?).to be_true
    end
 
    it "zwraca true dla pustej tablicy" do
      expect([].zaden_pusty?).to be_true
    end
  end
end