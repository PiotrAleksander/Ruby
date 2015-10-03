require 'rss'
require 'open-uri'

URL = "http://www.marstoday.com/rss/mars.xml"
open(URL) do |h|
  resp = h.read
  result = RSS::Parser.parse(resp, false)
  puts "Kanał: #{result.channel.title}"
  result.items.each_with_index do |item, i|
    i+=1
	puts "#{i} #{item.title}"
  end
end