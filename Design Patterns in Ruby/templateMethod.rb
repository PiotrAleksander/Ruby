class Report
  def initialize
    @title = 'Raport miesięczny'
	@text = ['Wszystko idzie', 'naprawdę dobrze.']
  end
  
  def output_report
    output_start
	output_head
	@text.each do |line|
	  output_line(line)
	end
	output_end
  end

  def output_start
  end
  
  def output_head
    output_line(@title)
  end
  
  def output_body_start
  end
  
  def output_line(line)
    raise 'Wywołano metodę abstrakcyjną output_line'
  end
  
  def output_body_end
  end
  
  def output_end
  end
end

class HTMLReport < Report
  def output_start
    puts ('<html>')
  end
  
  def output_head
	puts('	<head>')
	puts("		<title>#{@title}</title>")
	puts('	</head>')
  end
  
  def output_body_start
	puts('<body>')
  end
  
  def output_line(line)
	puts("	<p>#{line}</p>")
  end
  
  def output_body_end
	puts('</body>')
  end
  
  def output_end
	puts ('</html>')
  end
end

class PlainTextReport < Report
  
  def output_start
  end
  
  def output_body_start
  end
  
  def output_line(line)
    puts line
  end
  
  def output_body_end
  end
  
  def output_end
  end
  
end

report = HTMLReport.new
report.output_report
print "\n"
report = PlainTextReport.new
report.output_report