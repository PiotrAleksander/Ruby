class NumberStore
  include Enumerable
  attr_reader :neg_nums, :pos_nums
  
  def add(foo)
    if foo.respond_to? :to_i
	  foo_i = foo.to_i
	  if foo_i < 0
	    @neg_nums.push foo_i
	  else
	    @pos_nums.push foo_i
	  end
	else
	  raise "Nie jest liczbą.\n"
	end
  end

  def each
    @neg_nums.each {|i| yield i}
	@pos_nums.each {|i| yield i}
  end
  
  def initialize
    @neg_nums = []
	@pos_nums = []
  end
end

