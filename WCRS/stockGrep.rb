require 'open-uri'
require 'csv'

def get_info stock_symbol
  print "#{stock_symbol} - aktualne notowania akcji"
  url = "http://download.finance.yahoo.com/d/quotes.csv" + "?#{stock_symbol}&f=sl1d1t1c1ohgv&e=.csv"
  print "Połączenie z #{url}\n\n\n"
  
  csv = CSV.parse(open(url).read)
  
  csv.each do |row|
    print "-------------------------"
	print "Informacja z godz. #{row[3]} dnia #{row[2]}\n\n"
	print "#{row[0]}, ostatnie notowanie to - $#{row[1]} (wzrost o #{row[4]})\n\n"
	print "\tOtwarcie $#{row[5]}"
	print "\tDzisiejszy zakres $#{row[7]} - ${row[6]}"
  end
  print "-------------------------"
end

print "Podaj symbol akcji (oddziel spacją więcej symboli):"
stock_symbols = gets.upcase

stock_symbols.split.each do |symbol|
  get_info(symbol)
end