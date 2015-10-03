require 'drb'

class Warner
  include DRbUndumped
  
  def initialize(ticker, limit)
    @limit = limit
	ticker.add_observer(self) #wszystkie obiekty klienta są obserwatorami
  end
end

class WarnLow < Warner
  def update(time, price)
    if price < @limit
	  print "--- #{time.to_s}: Cena spadła poniżej #@limit: #{price}\n"
	end
  end
end

class WarnHigh < Warner
  def update(time, price)
    if price > @limit
	  print "+++ #{time.to_s}: Cena przekroczyła #@limit: #{price}\n"
	end
  end
end

DRb.start_service
ticker = DRbObject.new(nil, "druby://localhost:9001")

WarnLow.new(ticker, 90)
WarnHigh.new(ticker, 110)

puts 'Naciśnij [Enter], aby wyjść.'
gets