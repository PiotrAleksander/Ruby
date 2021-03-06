require 'benchmark'

def merge(a1, a2)
  ret = []
  
  while (true)
    if a1.empty?
	  return ret.concat(a2)
	end
	if a2.empty?
	  return ret.concat(a1)
	end
	
	if a1[0] < a2[0]
	  ret << a1[0]
	  a1 = a1[1...a1.size]
	else
	  ret << a2[0]
	  a2 = a2[1...a2.size]
	end
  end
end

def merge_sort(a)
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
  
  a1 = merge_sort(a1)
  a2 = merge_sort(a2)
  
  return merge(a1, a2)
end

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("10000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}
a =  Benchmark.measure {big_array_sorted = merge_sort(big_array)}
print a

File.open("output_10xmerge_sort.txt", "w") do |out|
  out.puts a
  out.puts big_array_sorted
end