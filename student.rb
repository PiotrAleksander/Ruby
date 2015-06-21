
class Student
  attr_accessor :first_name, :last_name, :primary_phone_number

  def introduction
    puts "Hi, #{first_name} #{last_name}"
  end
end
student = Student.new
puts "What is your first name?"
student.first_name = gets.chomp
puts "What is your last name?"
student.last_name = gets.chomp
student.introduction
puts "What a nice name!"
thank = gets.chomp