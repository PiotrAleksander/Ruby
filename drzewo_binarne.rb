require 'benchmark' #TODO benchmarki testujące szybkość tego podejścia i tablicowego

class Drzewo #binarne, ale wywołanie jest niepotrzebnie dłuższe

  attr_accessor :lewa, :prawa, :data


  def initialize(x=nil)
   @lewa = nil
   @prawa = nil
   @data = x
  end
  
  def self.z_tablicy(tablica) #chyba wstawia dwukrotnie pierwszą wartość
    Drzewo.new(tablica.first).tap do |drzewo|
      tablica.each {|wartosc| drzewo.wstaw wartosc }
    end
  end

  
  def wstaw(x) #przegląda gałęzie od pnia (największa wartość) i wstawia wg. schematu lewa gałąź większa niż prawa
    if @data == nil
     @data = x
    elsif x <= @data
     if @lewa == nil
      @lewa = Drzewo.new x
     else
      @lewa.wstaw x
     end
    else
     if @prawa == nil
      @prawa = Drzewo.new x
     else
      @prawa.wstaw x
     end
    end
   end
  
  def przejrzyj() #metoda pomocnicza zbierająca w 
    tablica = [] #tablicy wartości z drzewa binarnego
    yield @data
    tablica << @lewa if @lewa != nil
    tablica << @prawa if @prawa != nil
    loop do
     break if tablica.empty?
     galaz = tablica.shift
     yield galaz.data
     tablica << galaz.lewa if galaz.lewa != nil
     tablica << galaz.prawa if galaz.prawa != nil
    end
  end
  
  def szukaj(x) #przeszukuje szczyty i odpowiadające im gałęzie
    if self.data == x
      return self
    else
      ldrzewo = lewa != nil ? lewa.szukaj(x) : nil #obiekt drzewo przypisany do @lewa
      return ldrzewo if ldrzewo != nil
      pdrzewo = prawa != nil ? prawa.szukaj(x) : nil #obiekt drzewo przypisany do @prawa
      return pdrzewo if pdrzewo != nil
    end
    nil
  end

  def porzadek() #ta metoda i następne różnią się tylko kolejnością rekurencyjnego wypisu wartości gałęzi
    @lewa.porzadek {|y| yield y} if @lewa != nil
    yield @data
    @prawa.porzadek {|y| yield y} if @prawa != nil
   end

  def preporzadek()
    yield @data
    @lewa.preporzadek {|y| yield y} if @lewa != nil
    @prawa.preporzadek {|y| yield y} if @prawa != nil
  end

  def poporzadek()
    @lewa.poporzadek {|y| yield y} if @lewa != nil
    @prawa.poporzadek {|y| yield y} if @prawa != nil
    yield @data
  end
  
  def wrostek() #wrostek to normalny w Polsce sposób zapisu działań arytmetycznych np. (2+1)*3. Polecam sprawdzić co to Notacja Polska i Odwrócona Notacja Polska, nie wymagają nawiasów.
    if @lewa != nil
      operatory = %w[* / + -].include? @lewa.data
      yield "(" if operatory
      @lewa.wrostek {|y| yield y}
      yield ")" if operatory
    end
    yield @data
    if @prawa != nil
      operatory = %w[* / + -].include? @prawa.data
      yield "(" if operatory
      @prawa.wrostek {|y| yield y} if @prawa != nil
      yield ")" if operatory
    end
  end
   
  def to_s #string, ale ograniczony dla czytelności []
    "[" +
    if lewa then lewa.to_s + "," else "" end +
    data.inspect +
    if prawa then "," + prawa.to_s else "" end + "]"
  end
  
  def usun(galaz) #trzeba powiązać z nowym obiektem, bo
    tab = []
	self.porzadek {|x| tab<<x}
	tab.usun galaz
	drzewo = Drzewo.new
	tab.each {|x| drzewo.wstaw x}
	return drzewo #tutaj zwraca nowy obiekt, zamiast zmieniać stary
  end
  
  def to_a #zwraca tablicę, nie udało mi się osiągnąć możliwości powrotu do kolejności z oryginalnej tablicy
    tab = []
    tab += lewa.to_a if lewa
    tab << data
    tab += prawa.to_a if prawa
    tab
  end
end

def dodaj_galaz(galezie) #standalone tworzący drzewa na podstawie obiektu klasy Array, nie działa jak należy
  galaz = galezie.shift
  drzewo = Drzewo.new galaz
  if %w[* / + -].include? galaz
    drzewo.lewa = dodaj_galaz galezie
    drzewo.prawa = dodaj_galaz galezie
  end
  drzewo
end