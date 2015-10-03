require 'RMagick'
include Magick
Dir['*.[Jj][Pp]*[Gg]'].each do |pic|
  image = Image.read(pic)[0]
  next if pic =~ /^th_/
  puts "Zmniejszanie do 10% --- #{pic}"
  thumbnail = image.scale(0.10)
  if File.exists?("th_#{pic}")
    puts "Nie można zapisać pliku - miniatura już istnieje."
	next
  end
  thumbnail.write "th_#{pic}"
end
