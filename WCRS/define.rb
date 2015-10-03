require 'open-uri'

unless ARGV[0]
  print "Musisz podać definiowane słowo."
  print "Sposób użycia: ruby define.rb <definiowane słowo>"
  exit
end

word = ARGV[0].strip

url = "http://dictionary.reference.com/browse/#{word}"

begin
  open(url) do |source|
  source.each_line do |x|
    if x =~ /No results found/
	puts "\nDefinicji nie znaleziono - sprawdź pisownię."
	exit
  end
    if x =~ /(1\.)<\/td> <td>(.*)<\/td/
	print "\n#{$1} #{2}"
	exit
  end
end
  puts "Niestety, nie można znaleść definicji."
end
rescue => e
  print "Wystąpił błąd - spróbuj ponownie. "
  print e
end