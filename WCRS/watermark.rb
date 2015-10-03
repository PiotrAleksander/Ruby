require 'RMagick'
include Magick

unless ARGV[0] and File.exists?(ARGV[0])
  puts "\n\nMusisz podać nazwę pliku: watermark.rb <nazwapliku>\n\n\n"
  exit
end

img = Image.read(ARGV[0]).first
watermark = Image.new(600, 50)

watermark_text = Draw.new
watermark_text.annotate(watermark, 0, 0, 0, 0, "Mrzygłosz") do
  watermark_text.gravity = CenterGravity
  self.pointsize = 50
  self.font_family = "Arial"
  self.font_weight = BoldWeight
  self.stroke = "none"
end

watermark.rotate!(45)
watermark = watermark.shade(true, 310, 30)
img.composite!(watermark, SouthWestGravity, HardLightCompositeOp)
watermark.rotate!(-90)
img.composite!(watermark, NorthWestGravity, HardLightCompositeOp)
watermark.rotate!(90)
img.composite!(watermark, SouthEastGravity, HardLightCompositeOp)
watermark.rotate!(-90)
img.composite!(watermark, NorthEastGravity, HardLightCompositeOp)

if File.exists?("wm_#{ARGV[0]}")
  puts "Zdjęcie już istnieje. Nie można zapisać pliku."
  exit
end

puts "Zapisywanie pliku wm_#{ARGV[0]}"
img.write("wm_#{ARGV[0]}")


