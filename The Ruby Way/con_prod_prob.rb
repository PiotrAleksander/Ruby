require 'thread'

buffer = SizedQueue.new(2)

producer = Thread.new do
  item = 0
  loop do
    sleep rand 0
	puts "Producent utworzyl element #{item}"
	buffer.enq item
	item += 1
  end
end

consumer = Thread.new do
  loop do
    sleep (rand 0)+0.9
	item = buffer.deq
	puts "Konsument odebral element #{item}"
	puts "	liczba elementow oczekujacych = #{buffer.num_waiting}"
  end
end

sleep 30