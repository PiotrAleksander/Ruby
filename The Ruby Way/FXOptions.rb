require 'fox16'

include Fox

class RadioButtonHandlerWindow < FXMainWindow
  def initialize(app)
    super(app, "Program obslugujacy przyciski opcji", nil, nil, DECOR_TITLE | DECOR_CLOSE)
	
	choices = ["Dobry", "Lepszy", "Najlepszy"]
	
	default_choice = 0
	@choice = FXDataTarget.new(default_choice)
	group = FXGroupBox.new(self, "Przykladowa grupa przyciskow opcji", LAYOUT_SIDE_TOP |
																									FRAME_GROOVE | 
																									LAYOUT_FILL_X)
   
    choices.each_with_index do |choice, index|
      FXRadioButton.new(group, choice, @choice, FXDataTarget::ID_OPTION+index, ICON_BEFORE_TEXT | LAYOUT_SIDE_TOP)
    end
  end
end

application = FXApp.new
main = RadioButtonHandlerWindow.new(application)
application.create
main.show(PLACEMENT_SCREEN)
application.run  