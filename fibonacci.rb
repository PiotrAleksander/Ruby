def fib(n, cache = {})
  if n == 0 || n == 1
    return n
  end
  cache[n] ||= fib(n-1, cache) + fib(n-2, cache)
end
puts "Która liczba w ciągu Fibonacciego?"
licz = gets.chop
while licz.downcase != "koniec"
puts fib licz.to_i
licz = gets.chop
end
puts "Na koniec jeszcze 14 i 24 element ciągu:"
puts fib 14
# => 377
puts fib 24
# => 46368
koniec = gets.chop