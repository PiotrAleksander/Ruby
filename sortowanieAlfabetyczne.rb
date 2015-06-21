slowa=[]
puts "Proszę podać słowa do posortowania:"
slowo=gets.chop
while slowo !=""
slowa.push slowo
slowo = gets.chop
end
puts slowa.sort
puts "Czy poprawnie?"
wybor = gets.chop
if wybor == "tak"
puts "Proszę bałdzo!"
wybor2=gets.chop
else
puts "Było miło!"
wybor2=gets.chop
end