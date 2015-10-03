require 'RMagick'
include Magick

unless ARGV[0]
  puts "\n\nMusisz podać nazwę pliku: resizePhoto.rb <nazwapliku>\n\n\n"
  exit
end

img = Image.read(ARGV[0]).first
width = nil
height = nil

img.change_geometry!('300x300') do |cols, rows, img|
  img.resize!(cols, rows)
  width = cols
  height = rows
end

file_name = "#{width}x#{height}_#{ARGV[0]}"

if File.exists?(file_name)
  puts "Zdjęcie już istnieje. Nie można zapisać pliku."
  exit
end

img.write(file_name)