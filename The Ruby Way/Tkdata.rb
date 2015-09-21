require 'tk' #uru 193

root = TkRoot.new() { title "Dzisiejsza data"}
str = Time.now.strftime("Mamy dzisiaj \n%B %d, %Y")
lab = TkLabel.new(root) do 
  text str
  pack("padx" => 15, "pady" => 10, "side" => "top")
end
btn_OK = TkButton.new do
  text "OK"
  command proc {puts "Uzytkownik wyrazil zgode."}
  pack("side" => "left")
end
Tk.mainloop
