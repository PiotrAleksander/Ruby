require 'rinda/tuplespace'

ts = Rinda::TupleSpace.new

producer = Thread.new do
  item = 0
  loop do
    sleep rand(0)
	puts "Producent stworzył element ##{item}"
  ts.write("Item", item)
	item += 1
  end
end

consumer = Thread.new do
  loop do
    sleep rand(0)
	tuple = ts.take ["Item", nil]
  word, item = tuple
    puts "Konsument odebrał element ##{item}"
  end
end

sleep 60