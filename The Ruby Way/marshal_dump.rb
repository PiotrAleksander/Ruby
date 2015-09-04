class Person

  attr_reader :name, :age, :balance
  
  def initialize(name, birthdate, beginning)
    @name = name
	@birthdate = birthdate
	@beginning = beginning
	@age = (Time.now - @birthdate)/365
	@balance = @beginning*(1.05*@age)
  end
  
  def marshal_dump
    Struct.new("Human", :name, :birthdate, :beginning)
	str = Struct::Human.new(@name, @birthdate, @beginning)
	str
  end
  
  def marshal_load(str)
    self.instance_eval do
	  initialize(str.name, str.birthdate, str.beginning)
	end
  end
end

p1 = Person.new("Rudy", Time.now - (14*365*86400), 100)
p [p1.name, p1.age, p1.balance]
str = Marshal.dump(p1)
p2 = Marshal.load(str)

p [p2.name, p2.age, p2.balance]
