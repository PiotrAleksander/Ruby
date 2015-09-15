require 'madeleine'

class Employee
  attr_accessor :name, :number, :address
  
  def initialize(name, number, address)
    @name = name
	@number = number
	@address = address
  end
  
  def to_s
    "Pracownik: imię #{name} numer: #{number} adres: #{address}"
  end
end

class EmployeeManager
  def initialize
    @employees = {}
  end
  
  def add_employee(e)
    @employees[e.number] = e
  end
  
  def change_address(number, address)
    employee = @employees[number]
	raise "Nie ma takiego pracownika" if not employee
	employee.address = address
  end
  
  def delete_employee(number)
    @employees.remove(number)
  end
  
  def find_employee(number)
    @employees[number]
  end
end

class AddEmployee
  def initialize(employee)
    @employee = employee
  end
  
  def execute(system)
    system.add_employee(@employee)
  end
end

class DeleteEmployee
  def initialize(number)
    @number = number
  end
  
  def execute(system)
    system.delete_employee(@number)
  end
end

class ChangeAddress
  def initialize(number, address)
    @number = number
	@address = address
  end
 
  def execute(system)
    system.change_address(@number, @address)
  end
end

class FindEmployee
  def initialize(number)
    @number = number
  end
  
  def execute(system)
    system.find_employee(@number)
  end
end

store = SnapshotMadeleine.new('employees') {EmployeeManager.new}

Thread.new do
  while true
    sleep(20)
	madeleine.take_snapshot
  end
end

tomasz = Employee.new('tomasz', '1001', 'ul. Kwiatowa 1')
henryk = Employee.new('henryk', '1002', 'os. Kosmonautów 13/8')

store.execute_command(AddEmployee.new(tomasz))
store.execute_command(AddEmployee.new(henryk))

puts store.execute_command(FindEmployee.new('1001'))
puts store.execute_command(FindEmployee.new('1002'))

store.execute_command(ChangeAddress.new('1001', 'ul. Główna 555'))

puts store.execute_command(FindEmployee.new('1001'))