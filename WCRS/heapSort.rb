require 'benchmark'

def heap_sort(a)
  size = a.length
  i = (size/2) - 1
  
  while i>=0
    sift_down(a, i, size)
	i-=1
  end
  
  i=size-1
  
  while i >= 1
    a[0], a[i] = a[i], a[0]
	sift_down(a, 0, i -1)
	i -= 1
  end
  return a
end

def sift_down(num, root, bottom)
  done = false
  max_child = 0 
  
  while root*2 < bottom and !done
    if root*2 == bottom
	  max_child = root*2
	elsif num[root*2].to_i > num[root*2+1].to_i
	  max_child = root*2
	else
	  max_child = root*2+1
	end
    if num[root] < num[max_child]
	  num[root], num[max_child] = num[max_child], num[root]
	  root = max_child
	else
	  done = true
	end
  end
end

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("10000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}
a = Benchmark.measure {big_array_sorted = heap_sort(big_array)}
print a
File.open("output_10xheap_sort.txt", "w") do |out|
  out.puts a
  out.puts big_array_sorted
end