class Array
  def ^(other)
    (self | other) - (self & other)
  end
  
  def subset?(other)
    self.each do |x|
	  if !(other.include? x)
	    return false
	  end
	end
	true
  end
  
  def superset?(other)
    other.subset?(self)
  end
  
  def powerset
    num = 2**self.size
	ps = Array.new(num, [])
	self.each_index do |i|
	  a = 2**i
	  b = 2**(i+1) -1
	  j = 0
	  while j < num-1
	    for j in j+a..j+b
		  ps[j] += [self[i]]
		end
		j += 1
	  end
	end
	ps
  end
  
  def randomize
    self.sort_by {rand}
  end
  
  def randomize!
    self.replace(self.randomize)
  end
  
  def pick_random
    self[rand(self.length)]
  end
  
  def random_each
    temp = self.randomize
	temp.each {|x| yield x}
  end
  
  def count
    k = Hash.new(0)
	self.each{|x| k[x] += 1}
	k
  end
  
  def invert
    h={}
	self.each_with_index{|x, i| h[x]=i}
	h
  end
  
  def sort_index
    d= []
	self.each_with_index{|x, i| d[i]=[x,i]}
	if block_given?
	  d.sort {|x, y| yield x[0], y[0]}.collect{|x| x[1]}
	else
	  d.sort.collect{|x| x[1]}
	end
  end
  
  def sort_with(ord=[])
    return nil if self.length != ord.length
	self.values_at(*ord)
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

