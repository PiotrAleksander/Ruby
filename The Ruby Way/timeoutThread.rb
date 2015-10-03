require 'timeout.rb'

flag = false
answer = nil

begin
  timeout(5) do
    puts "Chce otrzymac znacznik kontekstu klienta!"
	answer = gets.chomp
	flag = true
  end
rescue TimeoutError
  flag = false
end
  
if flag
  if answer == "znacznik kontekstu"
    puts "Wielkie dzieki! Moge pracowac dalej..."
  else
	puts "To nie jest znacznik kontekstu klienta!"
	exit
  end
else
  puts "To wszystko dzieje sie za wolno!"
  exit
end
  