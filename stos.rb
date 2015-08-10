class Stos

  attr_reader :stos
  
  def initialize
    @stos = []
  end
  
  def push(x)
    @stos << x
  end
  
  def pop
    p @stos.pop
  end
  
  def szczyt
    p @stos.last
  end
end