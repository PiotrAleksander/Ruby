def zeta(x,y,z) #jakaś kosztowna w wykonywaniu funkcja rozwiązująca prosty problem z dziedziny genetyki populacyjnej(chyba coś z wilkami i zającami)
  lim = 0.0001
  gen = 0
  loop do
    gen +=1
	p,q = x + y/2.0, z+y/2.0
	x1, y1, z1 = p*p*1.0, 2*p*q*1.0, q*q*0.9
	sum = x1+y1+z1
	x1 /= sum
	y1 /= sum
	z1 /= sum
	delta = [[x1,x],[y1,y],[z1,z]]
	break if delta.all? {|a,b| (a-b).abs < lim}
	x,y,z = x1,y1,z1
  end
  gen
end

g1 = zeta(0.8, 0.1,0.1)
p g1