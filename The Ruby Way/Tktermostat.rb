require 'tk'

Top = {'side' => 'top', 'padx' =>5, 'pady' =>5}
Left = {'side' => 'left', 'padx' =>5, 'pady' =>5}
Bottom = {'side' => 'bottom', 'padx' =>5, 'pady' =>5}

temp = 21

root = TkRoot.new {title "Termostat"}
top = TkFrame.new(root) {background "#606060"}
bottom = TkFrame.new(root)

tlab = TkLabel.new(top) do
  text temp.to_s
  font "{Arial} 53 {bold}"
  foreground "green"
  background "#606060"
  pack Left
end

TkLabel.new(top) do
  text "o"
  font "{Arial} 14 {bold}"
  foreground "green"
  background "#606060"
  pack Left.update({'anchor' => 'n'})
end

TkButton.new(bottom) do
  text " + "
  command proc {tlab.configure("text" =>(temp+=1).to_s)}
  pack Left
  relief "raised"
end

TkButton.new(bottom) do
  text " - "
  command proc {tlab.configure("text" =>(temp-=1).to_s)}
  pack Left
  relief "raised"
end

top.pack Top
bottom.pack Bottom

Tk.mainloop