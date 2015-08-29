require_relative 'mean.rb'
require_relative 'variance.rb'

def correlate(x,y)
  sum = 0.0
  x.each_index do |i|
    sum+=x[i]*y[i]
  end
  xymean = sum/x.size.to_f
  xmean = mean(x)
  ymean = mean(y)
  sx = sigma(x)
  sy = sigma(y)
  (xymean-(xmean*ymean))/(sx*sy)
end

a = [3,6,9,12,15,18,21]
b = [1.1,2.1,3.4,4.8,5.6]
c = [1.9,1.0,3.9,3.1,6.9]

c1 = correlate(a,a)
c2 = correlate(a, a.reverse)
c3 = correlate(b,c)

def correlate2(v)
  sum = 0.0
  v.each do |a|
    sum+= a[0]*a[1]
  end
  xymean = sum/v.size.to_f
  x = v.collect {|a| a[0]}
  y = v.collect {|a| a[1]}
  xmean = mean(x)
  ymean = mean(y)
  sx = sigma(x)
  sy = sigma(y)
  (xymean-(xmean*ymean))/(sx*sy)
end

d = [[1,6.1], [2.1,3.1], [3.9,5.0], [4.8,6.2]]

c4 = correlate2(d)

def correlate_h(h)
  correlate2(h.to_a)
end

e = {1 => 6.1, 2.1 => 3.1, 3.9 => 5.0, 4.8 => 6.2}

c5 = correlate_h(e)

p c1, c2, c3, c4, c5