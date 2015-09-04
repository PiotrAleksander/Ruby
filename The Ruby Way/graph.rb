class TriMatrix

  def initialize
    @store = []
  end
  
  def [](x,y)
    if x>y
	  index = (x*x+x)/2 + y
	  @store[index]
	else
	  raise IndexError
	end
  end
  
  def []=(x,y,v)
    if x>y
	  index = (x*x+x)/2 + y
	  @store[index] = v
	else
	  raise IndexError
	end
  end
end

class ZArray < Array #Zero Array
  
  def [](x)
    if x > size
	  for i in size+1..x
	    self[i]=0
	  end
	end
	v = super(x)
  end
  
  def []=(x,v)
    max = size
	super(x,v)
	if size - max > 1
	  (max..size-2).each do |i|
	    self[i] = 0
	  end
	end
  end
end

class LowerMatrix < TriMatrix
  
  def initialize
    @store = ZArray.new
  end
end

class Graph

  def initialize(*edges)
    @store = LowerMatrix.new
	@max = 0
	for e in edges
	  e[0], e[1] = e[1], e[0] if e[1] > e[0]
	  @store[e[0],e[1]] = 1
	  @max = [@max, e[0], e[1]].max
	end
  end
  
  def [](x,y)
    if x>y
	  @store[x,y]
	elsif x<y
	  @store[y,x]
	else
	  0
	end
  end
  
  def []=(x,y,v)
    if x>y
	  @store[x,y]=v
	elsif x < y
	  @store[y,x]=v
	else
	  0
	end
  end
  
  def edge? x,y
    x,y = y,x if x<y
	@store[x,y]==1
  end
  
  def add x,y
    @store[x,y] = 1
  end
  
  def remove x,y
    x,y = y,x if x<y
	@store[x,y] = 0
	if (degree @max) == 0
	  @max -= 1
	end
  end
  
  def vmax
    @max
  end
  
  def degree x
    sum = 0
	0.upto @max do |i|
	  sum += self[x,i]
	end
	sum
  end
  
  def each_vertex
    (0..@max).each {|v| yield v}
  end
  
  def each_edge
    for v0 in 0..@max
	  for v1 in 0..v0-1
	    yield v0,v1 if self[v0,v1]==1
	  end
	end
  end
  
  def connected?
    x = vmax
	k = [x]
	l = [x]
	for i in 0..@max
	  l << i if self[x,i]==1
	end
	while !k.empty?
	  y = k.shift
	  self.each_edge do |a,b|
	    if a==y || b==y
		  z = a==y ? b : a
		  if !l.include? z
		    l << z
			k << z
	      end
		end
	  end
	end
	if l.size < @max
	  false
	else
	  true
	end
  end
  
  def euler_circuit? #most w Królewcu(obecnie Kalingradzie), każdy węzeł dokładnie raz
    return false if !connected?
	for i in 0..@max
	  return false if degree(i) % 2 != 0
	end
	true
  end
  
  def euler_path? #każda krawędź odwiedzana tylko raz, przy przejściu wszystkich wierzchołków
    return false if !connected?
	odd = 0
	each_vertex do |x|
	  if degree(x) % 2 == 1
	    odd += 1
	  end
	end
	odd <= 2 
  end
end

mygraph = Graph.new([1,0],[0,3],[2,1],[3,1],[3,2])
puts mygraph.euler_circuit?

mygraph.each_vertex {|v| puts mygraph.degree(v)}

mygraph.each_edge do |a,b|
  puts "(#{a},#{b})"
end

mygraph.remove 1,3

mygraph.each_vertex {|v| p mygraph.degree v}
print "\nWierzchołek o największym stopniu: "
p mygraph.vmax

mygraph = Graph.new([0,1], [1,2],[2,3],[3,0],[1,3])

puts mygraph.connected?
puts mygraph.euler_path?

mygraph.remove 1,2
mygraph.remove 0,3
mygraph.remove 1,3

puts mygraph.connected?
puts mygraph.euler_path?

mygraph = Graph.new([1,0],[0,3],[2,1],[3,1],[3,2])
puts mygraph.euler_circuit?
mygraph.remove 1,3
puts mygraph.euler_circuit?