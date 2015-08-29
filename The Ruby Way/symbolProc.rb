class Symbol
  def to_proc
    proc {|obj, *args| obj.send(self, *args)}
  end
end

words = ["saew", "saew", "args", "bas", "words"]

p words.map(&:capitalize)