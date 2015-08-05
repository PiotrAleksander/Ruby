root = File.expand_path("../", File.dirname(__FILE__))
require "#{root}/lib/xo.rb"
 
puts "Witaj w Xo"
gracz1 = Xo::Gracz.new({kolor: "X", imie: "gracz1"})
gracz2 = Xo::Gracz.new({kolor: "O", imie: "gracz2"})
gracze = [gracz1, gracz2]
Xo::Gra.new(gracze).graj