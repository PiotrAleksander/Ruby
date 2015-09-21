class Duck
  def initialize(name)
    @name = name
  end
  
  def eat
    puts "Kaczka #{@name} je."
  end
  
  def speak
    puts "Kaczka #{@name} mówi kwa, kwa!"
  end
  
  def sleep
    puts "Kaczka #{@name} cicho śpi."
  end
end

class Frog
  def initialize(name)
    @name = name
  end
  
  def eat
    puts "Żaba #{@name} je."
  end
  
  def speak
    puts "Żaba #{@name} rechocze!"
  end
  
  def sleep
    puts "Żaba #{@name} nie śpi; rechocze całą noc!"
  end
end

class Algae
  def initialize(name)
    @name = name
  end
  
  def grow
    puts "Glon #{@name} korzysta z promieni słonecznych i rośnie."
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end
  
  def grow
    puts "Lilia wodna #{@name} unosi się na powierzchni, korzysta z promieni słonecznych i rośnie."
  end
end

class Tree
  def initialize(name)
    @name = name
  end
  
  def grow
    puts "Drzewo #{@name} rośnie."
  end
end

class Tiger
  def initialize(name)
    @name = name
  end
  
  def eat
    puts "Tygrys #{@name} pożera, co zechce."
  end
  
  def speak
    puts "Tygrys #{@name} ryczy!"
  end
  
  def sleep
    puts "Tygrys #{@name} zasypia w wybranym przez siebie miejscu."
  end
end

class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
	@animal_class = animal_class
  end
  
  def new_animal(name)
    @animal_class.new(name)
  end
  
  def new_plant(name)
    @plant_class.new(name)
  end
end

class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory
  
    @animals = []
	number_animals.times do |i|
	  animal = @organism_factory.new_animal("Zwierzę #{i}")
	  @animals << animal
	end
	@plants = []
	number_plants.times do |i|
	  plant = @organism_factory.new_plant("Roślina #{i}")
	  @plants << plant
	end
  end
  
  def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
	@animals.each {|animal| animal.eat}
	@animals.each {|animal| animal.sleep}
  end
  
  def new_organism(type, name)
    if type == :animal
	  @animal_class.new(name)
	elsif type == :plant
	  @plant_class.new(name)
	else
	  raise "Nieznany typ organizmu: #{type}"
	end
  end
end