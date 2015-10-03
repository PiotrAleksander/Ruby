require 'benchmark'

def quick_sort(f, aArray)
  return [] if aArray.empty?
  pivot = aArray[0]
  before = quick_sort(f, aArray[1..-1].delete_if {|x| not f.call(x, pivot)})
  after = quick_sort(f, aArray[1..-1].delete_if {|x| f.call(x, pivot) })
  return (before<<pivot).concat(after)
end

big_array = Array.new
big_array_sorted = Array.new
IO.foreach("10000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}

a =  Benchmark.measure {big_array_sorted = quick_sort(Proc.new {|x, pivot| x < pivot}, big_array)}
print a

File.open("output_10xquick_sort.txt", "w") do |out|
  out.puts a
  out.puts big_array_sorted
end