require 'fox16'

include Fox
application = FXApp.new
main = FXMainWindow.new(application, "Pola tekstowe")
simple = FXTextField.new(main, 20, nil, 0, JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_TOP)
simple.text = "Proste pole tekstowe."
passwd = FXTextField.new(main, 20, nil, 0, JUSTIFY_RIGHT|TEXTFIELD_PASSWD|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_TOP)
passwd.text = "Haslo"
real = FXTextField.new(main, 20, nil, 0, TEXTFIELD_REAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_TOP|LAYOUT_FIX_HEIGHT, 0, 0, 0, 30)
real.text = "1.0E+3"
int = FXTextField.new(main, 20, nil, 0, TEXTFIELD_INTEGER|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_TOP|LAYOUT_FIX_HEIGHT, 0, 0, 0, 30)
int.text = "1000"
application.create
main.show(PLACEMENT_SCREEN)
application.run