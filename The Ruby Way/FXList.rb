require 'fox16'

include Fox

class ListHandWindow < FXMainWindow
  def initialize(app)
    super(app, "Program oslugujacy liste", nil, nil, DECOR_TITLE | DECOR_CLOSE)
	@list = FXList.new(self, nil, 0, LIST_EXTENDEDSELECT | LAYOUT_FILL_X) #BROWSESELECT dla jednego wyboru
	@list.connect(SEL_COMMAND) do |sender, sel, pos|
	  puts pos.to_s + " => " + @names[pos]
	  puts 'Aktualnie zaznaczone elementy:'
	  @list.each {|item| puts " " + item.text if item.selected?}
	end
	@names = ["Walther", "Pinkman", "Groucho", "Goodman", "Miguel", "Hank", "Jr"]
	@names.each {|name| @list << name}
  end
end

application = FXApp.new
main = ListHandWindow.new(application)
application.create
main.show(PLACEMENT_SCREEN)
application.run
