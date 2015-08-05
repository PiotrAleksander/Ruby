require_relative "./xo.rb"
 
puts "Welcome to Xo"
bob = Xo::Player.new({color: "X", name: "bob"})
frank = Xo::Player.new({color: "O", name: "frank"})
players = [bob, frank]
Xo::Game.new(players).play