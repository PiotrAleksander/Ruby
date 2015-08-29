require 'mathn'

def nPrimes(i)
  list = []
  gen = Prime.instance
  gen.each do |prime|
    break if list.size==i
    list<<prime
  end
  list
end
print "Ile liczb? "
n = gets.chomp.to_i
p nPrimes(n)
koniec = gets.chomp
