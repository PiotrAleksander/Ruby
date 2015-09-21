require 'find'

class Expression
  def |(other)
    Or.new(self, other)
  end
  
  def &(other)
    And.new(self, other)
  end
  
  def all
    All.new
  end
  
  def bigger(size)
    Bigger.new(size)
  end
  
  def name(pattern)
    FileName.new(pattern)
  end
  
  def except(expression)
    Not.new(expression)
  end
  
  def writable
    Writable.new
  end
end

class All < Expression
  def evaluate(dir)
    results = []
	Find.find(dir) do |p|
	  next unless File.file?(p)
	  results << p
	end
	results
  end
end

class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end
  
  def evaluate(dir)
    results = []
	Find.find(dir) do |p|
	  next unless File.file?(p)
	  name = File.basename(p)
	  results << p if File.fnmatch(@pattern, name)
	end
	results
  end
end

class Bigger < Expression
  def initialize(size)
    @size = size
  end
  
  def evaluate(dir)
    results = []
	Find.find(dir) do |p|
	  next unless File.file?(p)
	  results << p if (File.size(p) > @size)
	end
	results
  end
end

class Writable < Expression
  def evaluate(dir)
    results = []
	Find.find(dir) do |p|
	  next unless File.file?(p)
	  results << p if (File.writable? p)
	end
	results
  end
end

class Not < Expression
  def initialize(expression)
    @expression = expression
  end
  
  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

class Or < Expression
  def initialize(expr1, expr2)
    @expr1 = expr1
	@expr2 = expr2
  end
  
  def evaluate(dir)
    results1 = @expr1.evaluate(dir)
	results2 = @expr2.evaluate(dir)
	(results1 + results2).sort.uniq
  end
end

class And < Expression
  def initialize(expr1, expr2)
    @expr1 = expr1
	@expr2 = expr2
  end
  
  def evaluate(dir)
    results1 = @expr1.evaluate(dir)
	results2 = @expr2.evaluate(dir)
	(results1 & results2)
  end
end

class Parser
  def initialize(text)
    @tokens = text.scan(/\(|\)|[\w\.\*]+/)
  end
  
  def next_token
    @tokens.shift
  end
  
  def expression
    token = next_token
	
	if token == nil
	  return nil
	
	elsif token == '('
	  result = expression
	  raise 'Oczekiwano znaku )' unless next_token == ')'
	  result
	
	elsif token == 'all'
	  return All.new
	  
	elsif  token == 'writable'
	  return Writable.new
	 
	elsif token == 'bigger'
	  return Bigger.new(next_token.to_i)
	 
	elsif token == 'filename'
	  return FileName.new(next_token)
	
	elsif token == 'not'
	  return Not.new(expression)
	  
	elsif token == 'and'
	  return And.new(expression, expression)
	
	elsif token == 'or'
	  return Or.new(expression, expression)
	  
	else
	  raise "Nieoczekiwany token: #{token}"
	end
  end
end
