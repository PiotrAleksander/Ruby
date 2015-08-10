class Fifo #first in first out

  attr_reader :kolejka 
  
  def initialize
    @kolejka = []
  end
  
  def push(x)
    @kolejka<<x
  end
  
  def pop
    p @kolejka.shift
  end
  
  def czolo
    p @kolejka.first
  end
end