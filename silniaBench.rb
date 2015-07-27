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
p silnia1(4)
p silnia2(5)
p silnia1(5)

tablica = [1,2,6,18,23,29,32,34,39,40,41]
Benchmark.bmbm do |bench|
  bench.report('Silnia 1') do
    100*silnia1(n)
  end
  bench.report('Silnia 2') do
    100*silnia2(n)
  end
end  
   
  