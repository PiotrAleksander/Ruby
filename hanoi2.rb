# Wieże Hanoi to trzy drążki, dwa początkowo puste - pomocnicze i drążek podstawowy na którym umieszczona zostaje seria drążków (donutów) o różnej średnicy.
# Każdy drążek utrzyma tylko wieżę, której mniejsze krążki nie są przesłonięte przez większe (przekrój ma piramidalny).
# Zadanie polega na przełożeniu wieży po jednym elemencie z pierwszego drążka na drugi.
# Tutaj wersja z jedenym wywołaniem terminalnym.
require 'benchmark'

def hanoi2(n,a,b) # n to wysokość, a indeks pierwszego drążka (0), b drugiego, c=3-a-b
  while n!=1
    hanoi2(n-1,a,3-a-b)
	  print "Przełóż dysk nr #{n} z #{a} na #{b}\n"
	n-=1
	a=3-a-b
  end
  print "Przesuń dysk nr 1 z #{a} na #{b}\n"
end

print "Podaj wysokość wieży: "
wys = gets.chomp.to_i
p hanoi2(wys,0,1)
a = Benchmark.measure {hanoi2(wys,0,1)}

File.open("output_hanoi2_wys#{wys}.txt", "w") do |out|
  out.puts a
end
