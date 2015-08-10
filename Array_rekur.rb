class Array
  def each_rekur(&blok) #dla zagnieżdzonych tablic, dla których alternatywnie można byłoby zastosować .flatten.each {blok}
    each do |elem|
	  if elem.is_a? Array
	    elem.each_rekur &blok
      else
	    blok.call elem #ale each_rekur jest elastyczniejszy
	  end
	end
  end
  
  def collect_rekur(&blok)
    collect do |elem|
	  if elem.is_a? Array
	    elem.collect_rekur(&blok)
	  else
	    blok.call elem
	  end
	end
  end
  
  def sort_rekur!
    sort! do |a,b|
	  a.sort_rekur! if a.is_a? Array
	  b.sort_rekur! if b.is_a? Array
	  a <=> b
	end
  end
end