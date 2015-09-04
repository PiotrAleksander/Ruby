module Enumerable
  def classify(&block) #dzieli kolekcję wejściową na więcej niż dwie grupy, różnie spełniające kryteria przekazane w bloku
    hash={}
	self.each do |x|
	  result = block.call(x)
	  (hash[result] ||= []) << x
	end
	hash
  end
end