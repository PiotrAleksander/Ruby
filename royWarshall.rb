def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end

class Warshall
  def initialize(macierz_sasiedztwa)
    @macierz_sasiedztwa=macierz_sasiedztwa
  end
 
  def macierzSciezek
    n=@macierz_sasiedztwa.length
    macierz=Array.new(@macierz_sasiedztwa)
    for x in 0...n
      for y in 0...n
      #Jeżeli nie ma ścieżki z y do x to nie testujemy [x][z], to zmienne, więc przy każdej iteracji oznaczają inne sąsiedztwo. 
        if macierz[y][x]==1
          for z in 0...n
            if macierz[x][z]==1
              macierz[y][z]=1
            end
          end
        end
      end
    end
    macierz
  end
  
  def droga
    n = @macierz_sasiedztwa.length
	@drogi = deep_copy(@macierz_sasiedztwa)
	for x in 0...n
	  for y in 0...n
	    if @drogi[x][y] == 1
	      @drogi[x][y] = y
	    end
	  end
	end
	for x in 0...n
	  for y in 0...n
	    if @drogi[y][x]!=0
		  for z in 0...n
		    if (@drogi[y][z]==0&&@drogi[x][z]!=0)
		      @drogi[y][z]=@drogi[y][x]
			end
		  end
		end
	  end
	end
	@drogi
  end

  def pokazSciezki
    print "\nSąsiedztwo:\n"
    @macierz_sasiedztwa.each{|c| print c,"\n"}
    print "Ścieżki:\n"
    macierzSciezek.each{|c| print c,"\n"}
  end 
  
  def wypisz(x,y)
    droga
	unless @drogi[x][y] == 0
	  k = x
	  while k!=y
	    print "Węzeł: #{k}\n"
		k = @drogi[k][y]
	  end
	  print "Węzeł: #{k}\n"
    else
      print "Droga nie istnieje.\n"	
	end
  end

end
g = Warshall.new([[0, 1, 0, 1, 0], [0, 0, 0, 1, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0], [0, 1, 0, 0, 0]])
g.wypisz(0,2)

g.pokazSciezki

DATA.rewind
num = 1
DATA.each_line do |wiersz|
  puts "#{'%03d' % num} #{wiersz}"
  num += 1
end
__END__