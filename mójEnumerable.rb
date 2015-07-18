module Enumerable
  
  def moj_each # Enumerable#moj_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end
  
  def kazdy_index # Enumerable#each_with_index
    return self unless block_given?
    for i in 0...length
      yield(self[i], i)
    end
  end

  def selektor # Enumerable#select
    return self unless block_given?
    new_array = []
    moj_each { |i| new_array << i if yield(i) }
    new_array
  end

  def wszystkie? # Enumerable#all?
    if block_given?
      moj_each { |i| return false unless yield(i) }
    else
      moj_each { |i| return false unless i }
    end
    true
  end

  def jakikolwiek? # Enumerable#any?
    if block_given?
      moj_each { |i| return true if yield(i) }
    else
      moj_each { |i| return true if i }
    end
    false
  end

  def zaden? # Enumerable#none?
    if block_given?
      moj_each { |i| return false if yield(i) }
    else
      moj_each { |i| return false if i }
    end
    true
  end

  def podlicz(num = nil) # Enumerable#count
    c = 0
    if block_given?
      moj_each { |i| c += 1 if yield(i) }
    elsif num.nil?
      c = length
    else
      moj_each { |i| c += 1 if i == num }
    end
    c
  end

  def mapuj(blok) # Enumerable#map
    tablica = []
    if blok
      my_each do |i|
        tablica << blok.call(i)
      end
      return tablica
    else
      return self
    end
  end

  def my_inject(num = nil)
    stos = num.nil? ? first : num
    moj_each { |i| stos = yield(stos, i) }
    stos
  end
end # koniec modułu
