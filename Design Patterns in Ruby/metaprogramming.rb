def new_plant(stem_type, leaf_type)
  plant = Plant.new
  
  if stem_type == :fleshy
    def plant.stem
	  'mięsiste'
	end
  else
    def plant.stem
	  'zdrewniałe'
	end
  end
  
  if leaf_type == :broad
    def plant.leaf
	  'liściaste'
	end
  else
    def plant.leaf
	  'iglaste'
	end
  end
  
  plant
end

def new_animal(diet, awake)
  animal = Animal.new
  
  if diet == :meat
    animal.extend(Carnivore)
  else
    animal.extend(Herbivore)
  end
  
  if awake == :day
    animal.extend(Diurnal)
  else
    animal.extend(Noctural)
  end
  
  animal
end

module Carnivore
  def diet
    'mięso'
  end
  
  def teeth
    'ostre'
  end
end

module Herbivore
  def diet
    'roślinność'
  end
  
  def teeth
    'miażdżące'
  end
end

module Noctural
  def sleep_time
    'dzień'
  end
  
  def awake_time
    'noc'
  end
end

module Diurnal
  def sleep_time
    'noc'
  end
  
  def awake_time
    'dzień'
  end
end

class Animal
end
class Plant
end

class CompositeBase
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def self.member_of(composite_name)
    attr_name = "parent_#{composite_name}"
	raise 'Definicja istniejącej metody' if instance_methods.include?(attr_name)
    code = %Q{
	  attr_accessor :#{attr_name}
	}
	class_eval(code)
  end
  
  def self.composite_of(composite_name)
    member_of composite_name
	
	code = %Q{
	  def sub_#{composite_name}s
        @sub_#{composite_name}s = [] unless @sub_#{composite_name}s
        @sub_#{composite_name}s
      end

      def add_sub_#{composite_name}(child)
        return if sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s << child
        child.parent_#{composite_name} = self
      end
   
      def delete_sub_#{composite_name}(child)
        return unless sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s.delete(child)
        child.parent_#{composite_name} = nil
      end		
	}
	class_eval(code)
  end
end

class Tiger < CompositeBase
  member_of(:population)
  member_of(:classification)
end

class Tree < CompositeBase
  member_of(:population)
  member_of(:classification)
end

class Jungle < CompositeBase
  def parent_population  #metoda do zepsucia w trakcie wykonywania programu, raise error 'Definicja istniejącej metody'
    puts "metoda nadpisywana"
  end
  composite_of(:population)
end

class Species < CompositeBase
  composite_of(:classification)
end

def member_of_composite?(object, composite_name)
  object.respond_to?("parent_#{composite_name}")
end