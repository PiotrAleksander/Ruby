class Pole
  attr_reader :x, :y
  protected :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def Pole.nazwa(s)
    a = (' '..'z').to_a #zbiera alfabet, później przydadzą się indeksy
    Pole.new(a.index(s.downcase[0]) - a.index('a'), a.index(s.downcase[1] ) - a.index('1')) #zamienia pierwszą część nazwy pola na współrzędną x, drugą na y. Przy ustalaniu współrzędnych porównuje kolejno indeksy litery i cyfry i odejmuje od nich indeksy a i 1.
  end
  
  def prawidlowe?
    (0...8).member? @x and (0...8).member? @y #member? znaczy czy jest w zasięgu
  end

  def to_s
    to_str
  end

  def to_str
    %w(a b c d e f g h)[@x] + %w(1 2 3 4 5 6 7 8)[@y] if prawidlowe?
  end

  def ==(c)
    @x == c.x and @y == c.y #przy porównywaniu dwóch pól porównuje obie współrzędne
  end

  def goncze?(c) #pozwolilem sobie na przymiotnik gończe, znaczy przynależne gońcowi, w kształcie litery L
    dx = (@x - c.x).abs #przekątna
    dy = (@y - c.y).abs #przekątna
    prawidlowe? and c.prawidlowe? and (dx == 1 && dy == 2 or dx == 2 && dy == 1) #ruch 1 w y i 2 x albo 2 w y i 1 w x
  end
end

def sciezka_gonca(start, finisz, *niedozwolone)

  plansza = (0...64).collect { |n| Pole.new(n % 8, n / 8) } #buduje zbiór 64 pól. Algorytm posuwa się po szachownicy wężykiem.
  plansza.reject! { |t| niedozwolone.include?(t) } #wyklucza zakazane pola, np. zajęte przez sojuszniczy pionek.
  
  x = 0 #pierwszy indeks słownika
  mapa = { x => [start] } #inicjacja słowniko-mapy, gdzie wylądują kolejne pola zwiedzane przez gońca
  plansza.delete(start) #z planszy usuwana jest pozycja startowa, żeby do niej nie wrócić w drugim ruchu
  
  until mapa[x].empty? or mapa[x].include?(finisz) do #zapełnia słownik możliwymi skokami, aż do finiszu
    x += 1 #na razie pętla jest nieskończona
    mapa[x] = mapa[x-1].inject([]) do |wejscie, wyjcie| #dodaje dozwolone ruchy do poprzedniej pozycji
      wejscie.concat(plansza.find_all { |i| i.goncze?(wyjcie) }) #szuka wszystkich osiągalnych pól dla danej pozycji
    end
	plansza.reject! { |i| mapa[x].include?(i) } #odrzuca zwiedzone już pola ze słownika osiągalnych pól, dzięki czemu wychodzimy z nieskończonej pętli.
  end
  
  if not mapa[x].empty? #jeżeli zostały osiągalne pola od pierwszego po starcie do finiszu
    droga = [finisz] #ścieżka budowana jest wstecznie
	until x == 0 #dopóki tablica osiągalnych pól nie opustoszeje
	  x-=1 #przesuwaj się wstecz
	  skoki = mapa[x].find_all { |t| t.goncze?(droga.first) } #dodawaj do listy skoków skoki osiągalne z ostatniego pola (finisz, przedostatni..pierwszy(e) osiągalne)
      droga[0,0] = skoki.sort_by { rand }.first #ścieżka jest posortowana, ale mogą zdarzyć się równorzędne pierwsze ruchy, więc wybierane są losowo
	end
	droga
  end
end

args = ARGV.collect { |arg| Pole.nazwa(arg) } #właściwy engine, pobierający argumenty(np. ruby knight.rb a1 b2) jako start i finisz
if args.any? { |c| not c.prawidlowe? }
  print "Nieprawidłowe dane wejściowe!\n"
else
  podroz = sciezka_gonca(*args)
  if podroz
    print "Droga Gońca to: " + podroz.join(", ")
  else
    print "Ścieżka jest zablokowana!"
  end
end

