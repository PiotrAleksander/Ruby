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

t = TriMatrix.new

t[3,2]=1
puts t[3,2]
