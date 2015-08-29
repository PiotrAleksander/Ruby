def mode(x)
  f = {}
  fmax = 0
  m = nil
  x.each do |v|
    f[v] ||= 0
	f[v] += 1
	fmax,m = f[v], v if f[v] > fmax
  end
  return m
end

data = [7,7,7,4,4,5,4,5,7,2,2,3,3,7,3,4]
p mode(data)