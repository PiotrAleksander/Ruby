def compose(*objects)
  threads = []
  for obj in objects do
    threads << Thread.new(obj) do |myobj|
	  me = Thread.current
	  me[:queue] = []
	  myobj.each {|x| me[:queue].push(x)}
	end
  end
  
  list = [0]
  while list.nitems > 0 do
    list = []
	for thr in threads
	  list << thr[:queue].shift
	end
	yield list if list.nitems > 0
  end
end

x = [1, 2, 3, 4, 5, 6, 7, 8]
y = " first\n second\n third\n fourth\n fifth\n"
z = %w[a b c d e f]

compose(x, y, z) {|a, b, c| puts a, b, c}
