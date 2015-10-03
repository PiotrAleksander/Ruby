require 'RMagick'
include Magick

unless ARGV[0]
  puts "\n\nMusisz podać nazwę pliku: bwPhoto.rb <nazwapliku>\n\n\n"
  exit
end

new_img = "cb_#{ARGV[0]}"
img = Image.read(ARGV[0]).first

img = img.quantize(256, GRAYColorspace)

if File.exists?(new_img)
  puts "Zdjęcie już istnieje. Nie można zapisać pliku."
  exit
end

img.write(new_img)