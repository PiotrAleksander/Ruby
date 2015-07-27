require 'rio'
require 'open-uri'
require 'uri'

unless ARGV[0]
  print "Określ adres URL."
  print "Sposób użycia: ruby scrape.rb <przetwarzany.adres.url>"
  exit
end

begin
  rio(ARGV[0]) > rio("#{URI.parse(ARGV[0].strip).host}.html")
  exit
rescue => e
  print "Wystąpił błąd."
  print e
end