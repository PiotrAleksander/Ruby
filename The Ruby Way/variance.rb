require_relative 'mean.rb'
data = [2,3,2,2,3,4,5,5,4,3,1,2]

def variance(x)
  m = mean(x)
  sum = 0.0
  x.each {|v| sum += (v-m)**2}
  sum/x.size
end

def sigma(x)
  Math.sqrt(variance(x))
end

p variance(data)
p sigma(data)