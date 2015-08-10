class Pattern
  def initialize(base, string)
    @base = base
    @seq = parse(string)
  end
  
  def [](index)
    value = @seq[index % @seq.size]
    return nil if value.nil?
    return @base + value
  end
  
  def size
    return @seq.size
  end
  
  def parse(string)
    characters = string.split(//)
    no_spaces = characters.grep(/\S/)
    return build(no_spaces)
  end
  
  def build(list)
    return [] if list.empty?
    duration = 1 + run_length(list[1..-1])
    value = case list.first
      when /-|=/ then nil
      when /\D/ then 0
      else list.first.to_i
    end
    return [[value, duration]] + build(list[1..-1])
  end
  
  def run_length(list)
    return 0 if list.empty?
    return 0 if list.first != "="
    return 1 + run_length(list[1..-1])
  end
end

