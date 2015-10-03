#uru 223
require 'pdf/writer'

def quadrant(pdf, quad)
  raise unless block_given?
  
  mx = pdf.absolute_x_middle
  my = pdf.absolute_y_middle
  pdf.save_state
  
  case quad
  when :ul
    pdf.translate_axis 0, my
  when :ur
    pdf.translate_axis mx, my
  when :ll
    nil #przekształcenie nie jest konieczne
  when :lr
    pdf.translate_axis mx, 0
  end
  
  pdf.scale_axis(0.5, 0.5)
  pdf.y = pdf.page_height
  yield
  pdf.restore_state
end

pdf = PDF::Writer.new
pdf.select_font("Times-Roman", 
					:encoding => "WinAnsiEncoding",
					:differences => {0x01 => "lozenge"})
mx = pdf.absolute_x_middle
my = pdf.absolute_y_middle

pdf.line(0, my, pdf.page_width, my).stroke
pdf.line(mx, 0, mx, pdf.page_height).stroke

quadrant(pdf, :ul) do
  x = pdf.absolute_right_margin
  r1 = 25
  
  40.step(1, -3) do |xw|
    tone = 1.0 - (xw/40.0) * 0.2
	pdf.stroke_style(PDF::Writer::StrokeStyle.new(xw))
	pdf.stroke_color(Color::RGB.from_fraction(1, tone, tone))
	pdf.line(x, pdf.bottom_margin, x, pdf.absolute_top_margin).stroke
	x -= xw+2
  end
  
  40.step(1, -3) do |xw|
    tone = 1.0 - (xw/40.0) * 0.2
	pdf.stroke_style(PDF::Writer::StrokeStyle.new(xw))
	pdf.stroke_color(Color::RGB.from_fraction(1, tone, tone))
	pdf.circle_at(pdf.left_margin + 10, pdf.margin_height - 15, r1).stroke
	r1 += xw
  end
  
  pdf.stroke_color(Color::RGB::Black)
  
  x = pdf.absolute_left_margin
  y = pdf.absolute_bottom_margin
  w = pdf.margin_width
  h = pdf.margin_height
  pdf.rectangle(x, y, w, h).stroke
  
  text = "The Ruby Way"
  
  y = pdf.absolute_top_margin
  50.step(5, -5) do |size|
    height = pdf.font_height(size)
	y -= height
	pdf.add_text(pdf.left_margin + 10, y, text, size)
  end
  
  (0...360).step(20) do |angle|
    pdf.fill_color(Color::RGB.from_fraction(rand, rand, rand))
	
	pdf.add_text(300 + Math.cos(PDF::Math.deg2rad(angle)) * 40,
					300 + Math.sin(PDF::Math.deg2rad(angle)) * 40,
					text, 20, angle)
	end
  end
  
  pdf.fill_color Color::RGB::Black 
  
  quadrant(pdf, :ur) do
    pdf.image("materac.png", :height => pdf.margin_height, :resize => :width)
	pdf.text("Materac".split, :justification => :center, :font_size => 36)
	pdf.text("2012".split, :justification => :center, :font_size => 24)
	pdf.move_pointer(24)
	info = <<-'EOS'.split($/).join(" ").squeeze(" ")
  This picture was taken during a walking vacation through the
  Olsztynish lowlands in September 2012 by Piotr Mrzygłowski.
    EOS
	pdf.text(info.split("\n"), :justification => :full, :font_size => 16, :left => 100, :right => 100)
  end
  
  pdf.fill_color Color::RGB::Black
  
  quadrant(pdf, :ll) do
    require 'color/palette/monocontrast'
	
	class IndividualI
	  def initialize(size = 100)
	    @size = size
	  end
	  
	  attr_accessor :size
	  
	  def half_i(pdf)
	    pdf.move_to(0, 82)
		pdf.line_to(0, 78)
		pdf.line_to(9, 78)
		pdf.line_to(9, 28)
		pdf.line_to(0, 28)
		pdf.line_to(0, 23)
		pdf.line_to(18, 23)
		pdf.line_to(18, 82)
		pdf.fill
	  end
	  private :half_i
	  
	  def draw(pdf, x, y)
	    pdf.save_state
		pdf.translate_axis(x, y)
		pdf.scale_axis(1 * (@size / 100.0), -1 * (@size / 100.0))
		
		pdf.circle_at(20, 10, 7.5)
		pdf.fill
		
		half_i(pdf)
		
		pdf.translate_axis(40, 0)
		pdf.scale_axis(-1, 1)
		
		half_i(pdf)
		pdf.restore_state
	  end
	end
	
	ii = IndividualI.new(24)
	
	x = pdf.absolute_left_margin
	y = pdf.absolute_top_margin
	
	bg = Color::RGB.from_fraction(rand, rand, rand)
	fg = Color::RGB.from_fraction(rand, rand, rand)
	pal = Color::Palette::MonoContrast.new(bg, fg)
	
	sz = 24
	
	(-5..5).each do |col|
	  pdf.fill_color pal.background[col]
	  ii.draw(pdf, x, y)
	  ii.size += sz
	  x += sz /2.0
	  y -= sz/ 2.0
	  pdf.fill_color pal.foreground[col]
	  ii.draw(pdf, x, y)
	  x += sz / 2.0
	  y -= sz / 2.0
	  ii.size += sz
	end
  end
  
  pdf.fill_color Color::RGB::Black
  
  quadrant(pdf, :lr) do
    pdf.text("The Gettysburg Address\n\n".split("\n"), :font_size => 36, :justification => :center)
	y0 = pdf.y + 18
	
	speech = <<-'EOS'.split($/).join(" ").squeeze(" ")
  Four score and seven years ago our fathers brought forth one
  this continent a new, nation, conceived in liberty and
  dedicated to the proposition that all men are created equal.
  Now we are engaged in a great civil war, testing whether
  that nation or any nation so conceived and so dedicated can
  long endure. We are met on a great battlefield of that war.
  We have come to dedicate a portion of that field as a final
  resting-place for those who here gave their lives that that
  nation might live. It is altogether fitting and proper that
  we should do this. But in a larger sense, we cannot
  dedicate, we cannot consecrate, we cannot hollow this
  ground. The brave men, living and dead who struggled here
  have consecrated it far above our poor power to add or
  detract. The world will little note nor  long remember what
  we say here, but it can never forget what they did here. It
  is for us the living rather to be dedicated here to the
  unfinished work which they who fought here have thys far so
  nobly advanced. It is rather for us to be here dedicated to
  the great task remaining before us that from these honored
  dead we take increased devotion to that cause for which they
  gave the last full measure of devotion that we here highly
  resolve that these dead shall not have died in vain, that
  this nation under God shall have a new birth of freedom, and
  that goverment of the people, by the people, for the people
  shall not perish from the earth.
  EOS
  
  pdf.text(speech.split("\n"), :justification => :full, :font_size => 14, :left => 50, :right => 50)
  pdf.move_pointer(36)
  pdf.text("U.S. President Abraham Lincoln, 19 November 1863".split("\n"), :justification => :right, :right => 100)
  pdf.text("Gettysburg, Pennsylvania".split("\n"), :justification => :right, :right => 100)
  pdf.rounded_rectangle(pdf.left_margin + 25, y0, pdf.margin_width - 50, y0 - pdf.y + 18, 10).stroke
end

pdf.save_as("4page.pdf")