module Enumerable
  def mash(&block)
    self.inject({}) do |wyjscie, ob|
      k, w = block_given? ? yield(ob) : ob
      wyjscie.merge(k => w) 
    end
  end
end