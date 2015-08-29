class Transition
  A, B = :A, :B
  T, F = true, false
  
  Table = {[A, F, F]=>[A, F], [B, F, F]=>[B, T],
				[A, T, F]=>[B, T], [B, T, F]=>[B, T],
				[A, F, T]=>[A, F], [B, F, T]=>[A, T],
				[A, T, T]=>[A, T], [B, T, T]=>[A, T]
				}
  def initialize(var, flag1, flag2)
    @state = A
	@proc1 = proc { flag1 === var.call}
	@proc2 = proc { flag2 === var.call}
	check?
  end
  
  def check?
    p1 = @proc1.call ? T : F
	p2 = @proc2.call ? T : F
	@state, result = *Table[[@state, p1, p2]]
	return result
  end
end

line = nil
trans = Transition.new(proc {line}, /=begin/, /=end/)
loop do break if eof? line = gets
  puts line if trans.check?
end