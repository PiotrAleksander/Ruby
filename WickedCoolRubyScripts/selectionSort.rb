require 'benchmark'

def selection_sort(a)
  
  a.each_index do |i|
    min_index = min(a, i)
	
	a[i], a[min_index] = a[min_index], a[i]
  end
	a
end

def min(subset, from)
  min_value = subset[from..-1].min
  min_index = subset[from..-1].index(min_value) + from
  return min_index
end

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}
print Benchmark.measure {big_array_sorted = selection_sort(big_array)}

File.open("output_selectionSort.txt", "w") do |out|
  out.puts big_array_sorted
end

