require 'tk'

root = TkRoot.new {title "Przyklad uzycia pol wyboru"}
top = TkFrame.new(root)

PackOpts = {"side" => 'top', 'anchor' => 'w'}

cb1var = TkVariable.new
cb2var = TkVariable.new
cb3var = TkVariable.new

cb1 = TkCheckButton.new(top) do
  variable cb1var
  text "Informatyka"
  command {puts "Przycisk 1 = #{cb1var.value}"}
  pack PackOpts
end

cb2 = TkCheckButton.new(top) do
  variable cb2var
  text "Muzyka"
  command {puts "Przycisk 2 = #{cb2var.value}"}
  pack PackOpts
end

cb3 = TkCheckButton.new(top) do
  variable cb3var
  text "Literatura"
  command {puts "Przycisk 3 = #{cb3var.value}"}
  pack PackOpts
end

top.pack PackOpts

Tk.mainloop