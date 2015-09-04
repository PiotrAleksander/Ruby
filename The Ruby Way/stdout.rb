diskfile = File.new("foofile", "w")
puts "Witaj..."
$stdout = diskfile
puts "Żegnaj!"
diskfile.close
$stdout= STDOUT
puts "To wszystko."