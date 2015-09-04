require 'observer'

class Employee
  include Observable
  
  attr_reader :name, :title, :salary
  
  def initialize(name, title, salary)
    @name = name
	@title = title
	@salary = salary
  end
  
  def salary=(new_salary)
    @salary = new_salary
	changed
	notify_observers(self)
  end
end

class Payroll
  def update(changed_employee)
  puts "Zdefiniować nowy przelew dla pracownika
  #{changed_employee.name}!"
  puts "Jego pensja wynosi teraz #{changed_employee.salary}!"
  end
end

class Taxman
  def update(changed_employee)
  puts "Wysłać pracownikowi #{changed_employee.name} nowe zeznanie podatkowe!"
  end
end

filip = Employee.new("Filip", "Operator Dźwigu", 30000)
payroll = Payroll.new
taxman = Taxman.new
filip.add_observer(payroll)
filip.add_observer(taxman)
filip.salary=35000