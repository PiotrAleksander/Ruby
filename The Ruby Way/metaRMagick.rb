require 'RMagick'

def show_info(fname)
  img = Magick::Image::read(fname).first
  fmt = img.format
  w, h = img.columns, img.rows
  dep = img.depth
  nc = img.number_colors
  nb = img.filesize
  xr = img.x_resolution
  yr = img.y_resolution
  res = Magick::PixelsPerInchResolution ? "cal" : "cm"
  puts <<-EOF
  Plik:	#{fname}
  Format:	#{fmt}
  Wymiary:	#{w}x#{h} pikseli
  Kolory:	#{nc}
  Rozmiar obrazu:	#{nb} bajtów
  Rozdzielczość:	#{xr}/#{yr} pikseli na #{res}
  EOF
  puts
end

show_info("materac.jpg")
