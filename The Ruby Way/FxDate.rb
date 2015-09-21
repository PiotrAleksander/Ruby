require 'fox16'

include Fox
application = FXApp.new
main = FXMainWindow.new(application, "Dzisiejsza data")
str = Time.now.strftime("&Mamy dzisiaj %B %d, %Y")
button = FXButton.new(main, str)
button.connect(SEL_COMMAND) {application.exit}
application.create
main.show(PLACEMENT_SCREEN)
application.run