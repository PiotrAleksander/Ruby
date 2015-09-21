require 'fox16'

include Fox

application = FXApp.new
main = FXMainWindow.new(application, "Proste menu")
menubar = FXMenuBar.new(main, LAYOUT_SIDE_TOP | LAYOUT_FILL_X)
filemenu = FXMenuPane.new(main)
quit_cmd = FXMenuCommand.new(filemenu, "&Zamknij\tCtl-Q")
quit_cmd.connect(SEL_COMMAND) {application.exit}
FXMenuCommand.new(filemenu, "&Minimalizuj\tCtl-I") do |cmd|
  cmd.connect(SEL_COMMAND) {main.minimize}
end
FXMenuTitle.new(menubar, "&Plik", nil, filemenu)
application.create
main.show(PLACEMENT_SCREEN)
application.run