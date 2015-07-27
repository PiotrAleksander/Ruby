require 'english'
unless ARGV[0]
  puts "\nMusisz podać szukany tekst."
  puts "Sposób użycia: ruby rubyGrep.rb \"szukany_tekst\" '**/*'"
  exit
end

pattern = ARGV[0]
glob = ARGV[1]

Dir[glob].each do |file|
  next unless File.file?(file)
    File.open(file, "rb") do |f|
	  f.each_line do |line|
	    puts "#{File.expand_path(file)}: Wiersz: #{$INPUT_LINE_NUMBER}: #{line}" if line.include?(pattern)
	  end
	end
end