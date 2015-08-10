def szukaj(w, t)
  i = 0
  j = 0
  m = w.length
  n = t.length
  while (j<m && i<n)
    if t[i]!=w[j]
	  i-=j-1
	  j=-1
	end
    i+=1
    j+=1
  end
  if j==m
    print "Znaleziono #{w} na #{i-m+1} miejscu w tekście.\n"
	exit
  else
    print "Nie znaleziono."
	exit
  end
end

p szukaj("strona","na tej stronie nie ma slowa strona")