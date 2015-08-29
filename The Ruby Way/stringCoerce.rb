class String

  def coerce(n)
    if self['.']
	  [n, Float(self)]
	else
	  [n, Integer(self)]
	end
  end

end