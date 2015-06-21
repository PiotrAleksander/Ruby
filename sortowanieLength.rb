def sort_string(string)
 string.split.sort{|x,y| x.length<=>y.length}.join(' ')
 
end
puts "Proszę podać sentencję do posortowania:"
zdanie=gets.chop
puts sort_string(zdanie)
koniec=gets.chop
