require 'RMagick'

img = Magick::Image.read("materac.jpg").first
img.write("materac.PNG")