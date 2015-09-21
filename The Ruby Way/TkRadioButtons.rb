require 'tk'

root = TkRoot.new {title "Przyklad uzycia pol wyboru"}
top = TkFrame.new(root)

PackOpts = {"side" => 'top', 'anchor' => 'w'}

major = TkVariable.new

b1 = TkRadioButton.new(top) do
  variable major
  text "Informatyka"
  value 1
  command {puts "Kierunek = #{major.value}"}
  pack PackOpts
end

b2 = TkRadioButton.new(top) do
  variable major
  text "Muzyka"
  value 2
  command {puts "Kierunek = #{major.value}"}
  pack PackOpts
end

b1 = TkRadioButton.new(top) do
  variable major
  text "Literatura"
  value 3
  command {puts "Kierunek = #{major.value}"}
  pack PackOpts
end

top.pack PackOpts
Tk.mainloop