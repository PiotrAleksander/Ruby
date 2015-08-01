# Wieże Hanoi to trzy drążki, dwa początkowo puste - pomocnicze i drążek podstawowy na którym umieszczona zostaje seria krążków (donutów) o różnej średnicy.
# Każdy drążek utrzyma tylko wieżę, której mniejsze krążki nie są przesłonięte przez większe (przekrój piramidalny).
# Zadanie polega na przełożeniu wieży po jednym elemencie z pierwszego drążka na drugi.
# Tutaj wersja rekurencyjna (zawierająca wywołanie samej siebie ze zmienionymi parametrami). Kosztowna - ((2**n) -1)*czas pojedyńczego przemieszczenia krążka.
require 'benchmark'
 
def hanoi(n, a, b) # n to wysokość, a indeks pierwszego drążka (0), b drugiego, c=3-a-b
  if n==1
    print "Przełóż dysk nr #{n} z #{a} na #{b}\n"
  else
    hanoi(n-1,a,3-a-b)
    print "Przełóż dysk nr #{n} z #{a} na #{b}\n"
    hanoi(n-1,3-a-b,b)
  end
end  

print "Podaj wysokość wieży: "
wys = gets.chomp.to_i
p hanoi(wys,0,1)
a = Benchmark.measure {hanoi(wys,0,1)}

File.open("output_hanoi_wys#{wys}.txt", "w") do |out|
  out.puts a
end