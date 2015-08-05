def liniowe(tab, x)
  n = tab.length
  for i in 0..n do
    if tab[i] != x
	  i<<1
	else
	  print "Znaleziono na #{i+1} pozycji."
	  exit
	end
	print "Nie znaleziono.\n"
  end
end

tablica = [1,2,6,18,23,29,32,34,39,40,41]
n = 41
liniowe(tablica, n)

koniec = gets.chomp