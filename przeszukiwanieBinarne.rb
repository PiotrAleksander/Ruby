def szukaj_bin(tablica, x)
  n = tablica.length
  left = 0
  right = n-1
  while left<=right
  	mid = (left+right)/2
    if tablica[mid]==x
	  print "Znalazłem na #{mid+1} pozycji!"
	  exit
	else
	  if tablica[mid]<x
	     left = mid+1
	  else
	    right = mid-1
	  end
	end
  end
end

tablica = [1,2,6,18,23,29,32,34,39,40,41]
n = 41
szukaj_bin(tablica, n)

koniec = gets.chomp
  