class Stos

  attr_reader :stos
  
  def initialize
    @stos = []
  end
  
  def push(x)
    @stos << x
  end
  
  def pop
    @stos.pop
  end
  
  def szczyt
    @stos.last
  end
  
  def empty?
    @stos.empty?
  end
  
end

def paren_match(str) #sprawdza poprawność składni podwyrażeń, więcej w przykładzie
  stack = Stos.new
  lsym = "{[(<"
  rsym = "}])>"
  str.each_byte do |byte|
    sym = byte.chr
	if lsym.include? sym
	  stack.push(sym)
	elsif rsym.include? sym
	  top = stack.szczyt
	  if lsym.index(top) != rsym.index(sym)
	    return false
	  else
	    stack.pop
	  end
	end
  end
  return stack.empty?
end

str1 = "(((a+b))*((c-d)-(e*f))"
str2 = "[[(a-(b-c))], [[x,y]]]"
p paren_match(str1)
p paren_match(str2)