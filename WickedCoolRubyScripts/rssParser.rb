require 'rss'
require 'open-uri'

source = "http://startups.antyweb.pl/startups.rss"
content = ""

open(source) do |s|
  content = s.read
end

rss = RSS::Parser.parse(content, false)

print "Czy chcesz zobaczyć opisy kanałów (t/n)? "
input = gets.chomp

desc = input == 't' || input == 'T'

print "\n\nTytuł: #{rss.channel.title}"
print "Opis:: #{rss.channel.description}"
print "Link: #{rss.channel.link}"
print "Data publikacji: #{rss.channel.date} \n\n"

rss.items.size.times do |i|
  print "#{rss.items[i].date} ... #{rss.items[i].title}"
  if desc
    print "#{rss.items[i].description}\n\n\n"
  end
end