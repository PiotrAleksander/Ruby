class ArrayIterator
  def initialize(array)
    @array = Array.new(array)
	@index = 0
  end
  
  def has_next?
    @index < @array.length
  end
  
  def item
    @array[@index]
  end
  
  def next_item
    value = @array[@index]
	@index += 1
    value
  end
end

def merge(a1, a2)
  merged = []
  
  i1 = ArrayIterator.new(a1)
  i2 = ArrayIterator.new(a2)
  
  while(i1.has_next? && i2.has_next?)
    if i1.item < i2.item
	  merged << i1.next_item
	else
	  merged << i2.next_item
	end
  end
  
  while(i1.has_next?)
    merged << i1.next_item
  end
  
  while(i2.has_next?)
    merged << i2.next_item
  end
  
  merged
end

def for_each_element(a)
  array = Array.new(a)
  i = 0
  while i<array.length
    yield(array[i])
    i += 1
  end
end
  
  
  