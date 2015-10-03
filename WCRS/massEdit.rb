unless ARGV[0]
  puts "\n\nMusisz określić nazwę pliku: massEdit.rb <nazwapliku>\n\n\n"
  exit
end

name = ARGV[0]
x=0

Dir['*.[Jj][Pp]*[Gg]'].each do |pic|
  new_name = "#{name}_#{"%.2d" % x+=1}#{File.extname(pic)}"
  puts "Zmiana nazwy: #{pic} ---> #{new_name}"
  File.rename(pic, new_name)
end