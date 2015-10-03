require 'RMagick'

img = Magick::ImageList.new
img.new_image(500, 500)
purplish = "#ff55ff"
yuck = "#5fff62"
bleah = "#3333ff"

line = Magick::Draw.new
50.step(450, 50) do |n|
  line.line(n, 50, n, 450) #linia pozioma
  line.draw(img)
  line.line(50, n, 450, n) #linia pionowa
  line.draw(img)
end

#Koło
cir = Magick::Draw.new
cir.fill(purplish)
cir.stroke('black').stroke_width(1)
cir.circle(250, 200, 250, 310)
cir.draw(img)

rect = Magick::Draw.new
rect.stroke('black').stroke_width(1)
rect.fill(yuck)
rect.rectangle(340, 380, 237, 110)
rect.draw(img)

tri = Magick::Draw.new
tri.stroke('black').stroke_width(1)
tri.fill(bleah)
tri.polygon(90, 320, 160, 370, 390, 120)
tri.draw(img)

img = img.quantize(256, Magick::GRAYColorspace)

img.write("rysunek.gif")