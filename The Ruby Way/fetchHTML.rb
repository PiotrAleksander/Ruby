require 'net/http'

begin
  h = Net::HTTP.new("www.marsdrive.com", 80)
  resp, data = h.get("/index.html", nil)
rescue => err
  puts "Błąd: #{err}"
  exit
end

puts "Otrzymano #{data.split.size} wierszy, #{data.size} bajtów."
#w pamięci pod zmienną data jest sfeczowana cały www.marsdrive.com/index.html