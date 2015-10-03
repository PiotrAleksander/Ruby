require 'open-uri'
require 'pathname'

unless ARGV[0]
  print "Musisz podać adres URL, aby wydobyć rysunki."
  print "Sposób użycia: ruby imageScrape.rb <przetwarzany adres URL>"
  exit
end

url = ARGV[0].strip
begin
  open(url, "User-Agent" => "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)") do |source|
  source.each_line do |x|
    if x =~ /<img src="(.+.[jpeg|gif])"\s+/
	  name = $1.split('""').first
	  name = url + name if Pathname.new(name).absolute?
	  copy = name.split('/').last
	  
	  File.open(copy, 'wb') do |f|
	    f.write(open(name).read)
	  end
	end
  end
rescue => e
  print "Wystąpił błąd - spróbuj ponownie."
  print e
end