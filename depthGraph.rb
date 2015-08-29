class Graph
  def initialize(graf)
    @graf = graf
	@n = @graf.length
  end
  
  attr_accessor :graf, :n
  
  def depth(x)
	v = Array.new(n, 0)
	p v
    for i in 0..@n
	  v[i] = 0 #tablica wierzchołków, żaden jeszcze nie zbadany
	end
	for i in 0..@n
	  if v[i] == 0
	    zwiedzaj(v,i)
	  end
	end
  end
  
  def zwiedzaj(wierz, i)
    wierz[i]=1
	for k in 0..@n
	  if @graf[i][k]!=0
	    if wierz[k]==0
		  zwiedzaj(wierz,k)
		end
	  end
	end
  end
end

g = Graph.new([[1,3,4],[0,2,4],[1,6,3]])
g.depth(6)