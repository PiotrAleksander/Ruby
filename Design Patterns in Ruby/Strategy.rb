class Report
  attr_reader :title, :text
  attr_accessor :formatter
  
  def initialize(&formatter)
    @title = 'Raport miesięczny'
	@text = ['Wszystko idzie', 'naprawdę dobrze.']
	@formatter = formatter
  end
  
  def output_report
    @formatter.call(self)
  end
end


HTMLFormatter = lambda do |context|
    puts('<html>')
	puts('	<head>')
	puts("	<title>#{context.title}</title>")
	puts('	</head>')
	puts('<body>')
	context.text.each do |line|
	  puts("	<p>#{line}</p>")
	end
	puts('</body>')
	puts('</html>')
	puts
end

PlainTextFormatter = lambda {|context|
    puts("****#{context.title}****")
	context.text.each do |line|
	  puts line
	end
    puts
}

report = Report.new(&HTMLFormatter)
report.output_report
print "\n"
report = Report.new(&PlainTextFormatter)
report.output_report
puts
report = Report.new do |context| #lambda definiowana w biegu
  puts "****#{context.title}****"
  context.text.each do |line|
    puts line
  end
end
report.output_report
