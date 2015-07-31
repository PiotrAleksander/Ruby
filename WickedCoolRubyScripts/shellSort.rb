require 'benchmark'

def shell_sort(a)
  i = 0
  j= 0
  size = a.length
  increment = size/2
  temp = 0
  
  while increment>0
    i = increment
	while i<size
	  j = i
	  temp = a[i]
	  while j>=increment and a[j-increment]>temp
	    a[j] = a[j - increment]
		j = j-increment
	  end
	  a[j] = temp
	  i+=1
    end
    if increment == 2
      increment = 1
    else
      increment = (increment/2).to_i
    end
  end
  return a
end

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("10000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}
a = Benchmark.measure {big_array_sorted = shell_sort(big_array)}
print a

File.open("output_10xshell_sort.txt", "w") do |out|
  out.puts a
  out.puts big_array_sorted
end