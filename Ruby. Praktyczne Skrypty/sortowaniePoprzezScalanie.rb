require 'benchmark'

def scal(a1, a2)
  wynik = []
  
  while (true)
    if a1.empty?
	  return wynik.concat(a2)
	end
	if a2.empty?
	  return wynik.concat(a1)
	end
	
	if a1[0] < a2[0]
	  wynik << a1[0]
	  a1 = a1[1...a1.size]
	else
	  wynik << a2[0]
	  a2 = a2[1...a2.size]
	end
  end
end

def sort_scal(a)
  if a.size == 1
    return a
  elsif a.size == 2
    if a[0] > a[1]
	  a[0], a[1] = a[1], a[0]
	end
	return a
  end
  
  size1 = (a.size / 2).to_i
  size2 = a.size - size1
  
  a1 = a[0...size1]
  a2 = a[size1...a.size]
  
  a1 = sort_scal(a1)
  a2 = sort_scal(a2)
  
  return scal(a1, a2)
end

duza_tablica = Array.new
duza_tablica_sorted = Array.new
IO.foreach("1000LosLiczb.txt", $\ = ' ') {|num| duza_tablica.push num.to_i}
a =  Benchmark.measure {duza_tablica_sorted = sort_scal(duza_tablica)}
print a

File.open("wynik_10xsort_scal.txt", "w") do |wyjscie|
  wyjscie.puts a
  wyjscie.puts duza_tablica_sorted
end