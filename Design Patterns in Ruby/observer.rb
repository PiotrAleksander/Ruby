module Subject
  def initialize
    @observers=[]
  end
  
  def add_observer(&observer)
    @observers<<observer
  end
  
  def delete_observer(observer)
    @observers.delete(observer)
  end
  
  def notify_observers
    @observers.each do |observer|
	  observer.call(self)
	end
  end
end

class Employee
  include Subject
  
  attr_accessor :name, :title, :salary
  
  def initialize(name, title, salary)
    super()
    @name = name
	@title = title
	@salary = salary
  end
  
  def salary=(new_salary)
    @salary = new_salary
	notify_observers
  end
end




filip = Employee.new("Filip", "Operator Dźwigu", 30000)

filip.add_observer do |changed_employee|
  puts "Zdefiniować nowy przelew dla pracownika
  #{changed_employee.name}!"
  puts "Jego pensja wynosi teraz #{changed_employee.salary}!"
end
filip.salary=32000
filip.add_observer do |changed_employee|
    puts "Wysłać pracownikowi #{changed_employee.name} nowe zeznanie podatkowe!"
end
filip.salary=35000
p filip
filip.salary=40000
