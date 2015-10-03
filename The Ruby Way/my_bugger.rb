STDOUT.sync = true

def palindrome?(word)
  word == word.reverse
end

def signature(w)
  w.split("").sort.join
end

def anagrams?(w1, w2)
  signature(w1) == signature(w2)
end

print "Wpisz pierwszy wyraz: "
w1 = gets.chomp

print "Podaj inny wyraz: "
w2 = gets.chomp

verb = palindrome?(w1) ? "jest" : "nie jest"
puts "'#{w1}' #{verb} palindromem."

verb = palindrome?(w2) ? "jest" : "nie jest"
puts "'#{w2}' #{verb} palindromem"

verb = anagrams?(w1, w2) ? "są" : "nie są"
puts "'#{w1}' i '#{w2}' #{verb} anagramami."