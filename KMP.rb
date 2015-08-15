def szukaj(w, s)
  i = 0
  j = 0
  n = s.length
  m = w.length
  t = T(w)
    while j+i < n  
    if w[j] == s[j+i]  
      j += 1  
      return i  if j == m  
    else  
      i += j - t[j]  
      j = [0, t[j]].max  
    end  
  end  
  print "Nie znaleziono w podanym ciągu #{n} znaków."
  exit
end

def T(w, tab=[-1,0])
  pos = 2
  cnd = 0
  m = w.length
  while pos <  m
    if w[pos-1] == w[cnd]
	  cnd +=1
	  tab[pos] = cnd
	  pos += 1
    elsif cnd > 0
      cnd = tab[cnd]
    else
	  tab[pos] = 0
	  pos += 1
    end
  end
  return tab
end