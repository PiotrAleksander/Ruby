unless ARGV[0]
  print "\nMusisz podać plik do sprawdzenia."
  print "Sposób użycia: ruby wordFreq.rb plik_do_sprawdzenia.txt "
  exit
end

unless File.exist?(ARGV[0])
  print "\nNie można znaleźć pliku - sprawdź ścieżkę."
  print "Sposób użycia: ruby wordFreq.rb plik_do_sprawdzenia.txt "
  exit
end

file = ARGV[0]
words = Hash.new(0)
File.open(file, "r").each_line do |line|
  line.scan(/\b\w+\b/) {|i| words[i]+=1}
end

sorted = words.sort_by {|a| a[1]}

temp = sorted.length

50.times do
  temp -= 1
  print "\"#{sorted[temp][0]}\": liczba wystąpień to #{sorted[temp][1]}\n"
end