def intergrate(x0, x1, dx=(x1-x0)/1000.0) #suma Riemanna
  x = x0
  sum = 0
  loop do
    y = yield(x)
	sum += dx*y
	x += dx
	break if x > x1
  end
  sum
end

def f(x)
  x**2
end

print "Funkcji f(x)=x**2 całka oznaczona: "
z = intergrate(0.0, 5.0) {|x| f(x)}

puts z, "\n"