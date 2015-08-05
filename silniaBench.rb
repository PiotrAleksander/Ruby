require 'benchmark'
include Benchmark
def silnia1(x)
  if(x==0)
    return 1
  else
    return x*silnia1(x-1)
  end
end

def silnia2(x, tmp=1)
  if (x==0)
    return tmp
  else
    return silnia2(x-1,x*tmp)
  end
end

def silnia_it(x)
  res = 1
  while x!=0
    res=x*res
	x-=1
  end
  return res
end

tablica = [1,2,6,18,23,29,32,34,39,40,41,56,59,61,72,83,99,102,153,200,1000]
n = tablica[-1]
p silnia1(n)
p silnia2(n)
p silnia_it(n)
a = Benchmark.bmbm do |bench|
  bench.report('Silnia 1') do
    100*silnia1(n)
  end
  bench.report('Silnia 2') do
    100*silnia2(n)
  end
  bench.report('Silnia iteracyjna') do
    100*silnia_it(n)
  end
end  

File.open("testSilnia.txt", "w") do |plik|
  plik.puts a
end
 
  
   
  