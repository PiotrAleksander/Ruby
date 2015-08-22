def kompozycja(g1=[[]], g2=[[]], g3=[[]])
  z = 0
  n = g1.size
  for x in 0..n
    for y in 0..n
	  loop do
	    if z==n
		  break
		elsif (g1[x][z]==1) && (g2[z][y]==1)
		  g3<< 1
		end
		z+=1
	  end
	end
  end
  return g3
end

