class Floyd 
  def initialize(tablicaWag=nil,oo=1.0/0.0) #Interpreter zwraca Infinity
    @tablicaWag=tablicaWag
    @oo=oo #wartość nie do siągnięa przez sumę wag krawędzi grafu. Wstawiana zamiast "nie ma drogi z tego wierzchołka do tamtego"
  end
  
  attr_accessor :oo
 
  attr_accessor :tablicaWag, :r
 
  def odleglosc
    n=@tablicaWag.length
    tablicaOdl=Array.new(@tablicaWag)
	@r = Array.new(n, Array.new(n,@oo))
  
    for k in 0...n
      for i in 0...n
        if tablicaOdl[i][k]<@oo 
          for j in 0...n
            odleglosc = tablicaOdl[i][k] + tablicaOdl[k][j]
            if odleglosc<tablicaOdl[i][j]
              tablicaOdl[i][j]=odleglosc
		      @r[i][j] = k
            end
          end
        end
      end
    end
    tablicaOdl
  end

  def pokazOdl
    print "Wagi:\n"
    @tablicaWag.each{|c| print c.to_s.gsub(@oo.to_s,"oo"),"\n"}
    print "Odległości:\n"
    odleglosc.each{|c| print c.to_s.gsub(@oo.to_s,"oo"),"\n"}
  end
  
  def pokazDroge(i,j) #nienajfajniejsza funkcja, bo zwraca nie drukuje "droga nieznaleziona", czy podobnego komunikatu
    k = @r[i][j]
	if k!=j && k!=@oo && k>i
	  pokazDroge(i,k)
	  print "#{k}\n"
	end
  end
end

floyd=Floyd.new
 oo=floyd.oo
 floyd.tablicaWag=[[oo,10,oo,30,oo,oo,oo],[oo,oo,15,oo,40,oo,oo],[oo,oo,oo,5,20,oo,oo],[oo,oo,oo,oo,oo,oo,oo],[oo,oo,oo,oo,oo,20,10],[oo,oo,oo,oo,oo,oo,5],[oo,oo,oo,25,oo,oo,oo]]
 floyd.pokazOdl
 floyd.pokazDroge(1,3)