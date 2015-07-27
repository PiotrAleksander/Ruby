require 'mechanize'

unless ARGV[0]
  print "Musisz podać adres witryny."
  print "Sposób użycia: ruby linkScrape.rb <przetwarzany adres URL>"
  exit
end

agent = Mechanize.new
agent.set_proxy('localhost', 8080)

begin
  page = agent.get(ARGV[0].strip)
  
  page.links.each do |l|
    if l.href.split(" ")[0] == '/'
	  print "#{ARGV[0]}#{l.href}"
	else
	  print l.href
	end
  end
rescue => e
  print "Wystąpił błąd."
  print e
  retry
end