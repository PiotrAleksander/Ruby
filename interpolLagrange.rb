N = 3 #stopień wielomianu interpolującego (wyznaczony metodą Vandermonde'a)
#w istocie funkcja x**(1/2)
arg=[3.0, 5.0, 6.0, 7.0]
war=[1.732, 2.236, 2.449, 2.646]

def interpol(z, x, y) #podziękowania dla P. Wróblewskiego za przetłumaczenie wzoru Lagrange'a na zagnieżdżoną pętlę i podanie stopnia wielomianu skonstuowanego przy użyciu wyznacznika Vandermonde'a
  wnz=0
  om=1.0
  for i in 0..N
    om*=(z-x[i])
	w = 1.0
	for j in 0..N
	  if i!=j
	    w*=(x[i]-x[j])
	  end
	end
	wnz += y[i]/(w*(z-x[i]))
  end
  wnz*=om
  return wnz
end

p interpol(6.2, arg, war) #argument równy któremuś z tablicy arg zwraca NaN