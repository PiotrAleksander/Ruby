require 'benchmark'

def sortowanie_babelkowe(tablica)
  loop do
  i, x = 0, 0 #x to zmienna pomocnicza
    while i < tablica.length - 1
	  if tablica[i + 1] < tablica[i]
      tablica[i], tablica[i + 1] = tablica[i + 1], tablica[i]
      x += 1 #służąca za znacznik przebiegu sortowania
	  end
      i += 1
    end
    break if x == 0 # i wyłączy pętle, jeżeli tablica jest, bądź była posortowana
  end
  tablica
end

def sortowanie_poprzez(tablica)
  loop do
  i, x = 0, 0
    while i < tablica.length - 1
      if yield(tablica[i], tablica[i + 1]) > 0
      tablica[i], tablica[i + 1] = tablica[i + 1], tablica[i]
      x += 1
      end
      i += 1
    end
    break if x == 0
  end
  tablica
end
print sortowanie_babelkowe("zdanie, które zaraz zostanie posortowanie".split)

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("10000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}
a = Benchmark.measure {big_array_sorted = sortowanie_babelkowe(big_array)}
print a 
File.open("output_10xbubble_sort.txt", "w") do |out|
  out.puts a
  out.puts big_array_sorted
end
