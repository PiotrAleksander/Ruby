require 'drb'
require_relative 'drbObserver.rb'

#Generuje losową cenę.
class MockPrice
  MIN = 75
  RANGE = 50
  
  def initialize(symbol)
    @price = RANGE/2
  end
  
  def price
    @price += (rand() -0.5)*RANGE
	if @price < 0
	  @price = -@price
	elsif @price >= RANGE
	  @price = 2*RANGE - @price
	end
	MIN + @price
  end
end

#Cyklicznie odczytuje aktualną cenę akcji.
class Ticker
  include DRbObservable
  
  def initialize(price_feed)
    @feed = price_feed
	Thread.new {run}
  end
  
  def run
    lastPrice = nil
	loop do
	  price = @feed.price
	  print "Bieżąca cena: #{price}\n"
	  if price != lastPrice
	    lastPrice = price
		notify_observers(Time.now, price)
	  end
	  sleep 1
	end
  end
end

ticker = Ticker.new(MockPrice.new("MSFT"))

DRb.start_service('druby://localhost:9001', ticker)
puts "Naciśnij [ctrl]+[c], aby wyjść."
DRb.thread.join