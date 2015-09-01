class Fifo #first in first out

  attr_reader :kolejka 
  
  def initialize
    @kolejka = []
  end
  
  def push(x)
    @kolejka<<x
  end
  
  def pop
    @kolejka.shift
  end
  
  def czolo
    @kolejka.first
  end
  
  def length
    @kolejka.length
  end
  
  def empty?
    @kolejka.empty?
  end
end