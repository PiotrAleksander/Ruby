def random_select(array, n)
  new_array=[]
  n.times do 
    new_array << array[rand(array.length)]
end
  puts new_array
end
puts "Program prosi o zestaw liczb:"
odp1 = gets.chop
puts "Program wylosuje ile liczb z zestawu?:"
odp2 = gets.chop
puts random_select(odp1.split, odp2.to_i)



