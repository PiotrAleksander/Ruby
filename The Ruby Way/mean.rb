def mean(x)
  sum=0
  x.each {|v| sum += v}
  sum/x.size
end

def hmean(x) #harmoniczna
  sum=0
  x.each {|v| sum += (1.0/v)}
  x.size/sum
end

def gmean(x) #geometryczna
  prod=1.0
  x.each {|v| prod *= v}
  prod**(1.0/x.size)
end

data = [1.1, 2.3, 3.3, 1.2, 4.5, 2.1, 6.6]

am = mean(data)
hm = hmean(data)
gm = gmean(data)

p am, hm, gm