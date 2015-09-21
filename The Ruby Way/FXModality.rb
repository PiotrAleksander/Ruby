require 'fox16'

include Fox

class NonModalDialogBox < FXDialogBox
  def initialize(owner)
    super(owner, "Test okien dialogowych", DECOR_TITLE|DECOR_BORDER)
	text_options = JUSTIFY_RIGHT | FRAME_SUNKEN |
						FRAME_THICK | LAYOUT_SIDE_TOP
	@text_field = FXTextField.new(self, 20, nil, 0, text_options)
	@text_field.text = ""
	layout_options = LAYOUT_SIDE_TOP | FRAME_NONE |
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
	layout = FXHorizontalFrame.new(self, layout_options)
	options = FRAME_RAISED | FRAME_THICK |
					LAYOUT_RIGHT | LAYOUT_CENTER_Y
	hide_btn = FXButton.new(layout, "&Ukryj", nil, nil, 0, options)
	hide_btn.connect(SEL_COMMAND) {hide}
  end
  
  def text
    @text_field.text
  end
end

class ModalDialogBox < FXDialogBox
  def initialize(owner)
    super(owner, "Test okien dialogowych", DECOR_TITLE|DECOR_BORDER)
	
	text_options = JUSTIFY_RIGHT | FRAME_SUNKEN |
						FRAME_THICK | LAYOUT_SIDE_TOP
    @text_field = FXTextField.new(self, 20, nil, 0, text_options)
    @text_field.text = ""
    layout_options = LAYOUT_SIDE_TOP | FRAME_NONE | 
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
	layout = FXHorizontalFrame.new(self, layout_options)
	options = FRAME_RAISED | FRAME_THICK |
					LAYOUT_RIGHT | LAYOUT_CENTER_Y
	cancel_btn = FXButton.new(layout, "&Anuluj", nil, self, 0, options)
	cancel_btn.connect(SEL_COMMAND) do
	  app.stopModal(self, 0)
	  hide
	end
	
	accept_btn = FXButton.new(layout, "&Akceptuj", nil, self, 0, options)
	accept_btn.connect(SEL_COMMAND) do
	  app.stopModal(self, 1)
	  hide
	end
  end
  
  def text
    @text_field.text
  end
end

class DialogTestWindow < FXMainWindow
  def initialize(app)
    super(app, "Testy okien dialogowych", nil, nil, DECOR_ALL, 0, 0, 400, 200)
	layout_options = LAYOUT_SIDE_TOP | FRAME_NONE | 
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
	layout = FXHorizontalFrame.new(self, layout_options)
	button_options = FRAME_RAISED | FRAME_THICK |
							LAYOUT_CENTER_X | LAYOUT_CENTER_Y
	nonmodal_btn = FXButton.new(layout, "&Niemodalne okno dialogowe...", nil, nil, 0, button_options)
	nonmodal_btn.connect(SEL_COMMAND) do 
	  @non_modal_dialog.show(PLACEMENT_OWNER)
	end
	
	modal_btn = FXButton.new(layout, "&Modalne okno dialogowe...", nil, nil, 0, button_options)
	modal_btn.connect(SEL_COMMAND) do
	  dialog = ModalDialogBox.new(self)
	  if dialog.execute(PLACEMENT_OWNER) == 1
	    puts dialog.text
      end
	end
	
	getApp.addTimeout(2000, method(:onTimer))
	@non_modal_dialog = NonModalDialogBox.new(self)
  end
  
  def onTimer(sender, sel, ptr)
    text = @non_modal_dialog.text
	unless text == @previous
	  @previous = text
	  puts @previous
	end
	getApp.addTimeout(2000, method(:onTimer))
  end
  
  def create
    super
	show(PLACEMENT_SCREEN)
  end
end

application = FXApp.new
DialogTestWindow.new(application)
application.create
application.run