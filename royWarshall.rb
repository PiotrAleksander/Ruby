class Warshall
  def initialize(macierz_sasiedztwa)
    @macierz_sasiedztwa=macierz_sasiedztwa
  end
 
  def macierzSciezek
    n=@macierz_sasiedztwa[0].length
    macierz=Array.new(@macierz_sasiedztwa)
   for x in 0...n
     for y in 0...n
     #Jeżeli nie ma ścieżki z x do y to nie testujemy [x][z]
       if macierz[y][x]==1
         for z in 0...n
           if macierz[x][z]==1
             macierz[y][z]=1
           end
         end
       end
     end
   end
   return macierz
  end

  def pokazSciezki
    print "Sąsiedztwo:\n"
    @macierz_sasiedztwa.each{|c| print c,"\n"}
    print "Ścieżki:\n"
    macierzSciezek.each{|c| print c,"\n"}
  end 
end
g = Warshall.new([[0, 1, 0, 1, 0], [0, 0, 0, 1, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0], [0, 1, 0, 0, 0]])

g.pokazSciezki