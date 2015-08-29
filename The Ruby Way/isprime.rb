require 'mathn'

class Integer
  def prime?
    max = Math.sqrt(self).ceil
	max -= 1 if max % 2 == 0
	pgen = Prime.instance
	pgen.each do |factor|
	  return false if self % factor == 0
	  return true if factor > max
	end
  end
end