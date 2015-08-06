def fib(n, cache = {})
  if n == 0 || n == 1
    return n
  end
  cache[n] ||= fib(n-1, cache) + fib(n-2, cache)
end

def fibs(num)
    i = 0
    nast = 1
    j = 0
    while (num -= 1) > 0 do
        j = i + nast
        i = nast
        nast = j
    end
    return nast
end
puts "Która liczba w ciągu Fibonacciego?"
licz = gets.chop
while licz.downcase != "koniec"
puts fib licz.to_i
puts fibs licz.to_i
licz = gets.chop
end
puts "Na koniec nasteszcze 14 i 24 element ciągu:"
puts fib 14
# => 377
puts fib 24
# => 46368
koniec = gets.chop