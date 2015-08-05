class Array
  def wszystkie_puste?
    self.all? { |element| element.to_s.empty? }
  end
  
  def takie_same?
    self.all? { |element| element == self[0] }
  end
  
  def ktorys_pusty?
    self.any? { |element| element.to_s.empty? }
  end
  
  def zaden_pusty?
    !ktorys_pusty?
  end
end