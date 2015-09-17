require 'forwardable'

class EnhancedWriter
  attr_reader :check_sum
  
  def initialize(path)
    @file = File.open(path, "w")
	@check_sum = 0
	@line_number = 1
  end
  
  def write_line(line)
    @file.print(line)
	@file.print("\n")
  end
  
  def checksumming_write_line(data)
    data.each_byte {|byte| @check_sum = (@check_sum + byte) % 256}
	@check_sum += "\n".ord[0] % 256
	write_line(data)
  end
  
  def timestamping_write_line(data)
    write_line "#{Time.new}: #{data}"
  end
  
  def numbering_write_line(data)
    write_line "%{@line_number}: #{data}"
	@line_number += 1
  end
  
  def close
    @file.close
  end
end

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end
  
  def write_line(line)
    @file.print line
	@file.print "\n"
  end
 
  def pos
    @file.pos
  end
  
  def rewind
    @file.rewind
  end
  
  def close
    @file.close
  end
end

class WriterDecorator
  extend Forwardable
  
  def_delegators :@real_writer, :write_line, :rewind, :pos, :close
  
  def initialize(real_writer)
    @real_writer = real_writer
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
	@line_number = 1
  end
  
  def write_line(line)
    @real_writer.write_line "#{@line_number}: #{line}"
	@line_number += 1
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum
  
  def initialize(real_writer)
    @real_writer = real_writer
	@check_sum = 0
  end
  
  def write_line(line)
    line.each_byte {|byte| @check_sum = (@check_sum + byte) % 256}
	@check_sum += "\n".ord[0] % 256
	@real_writer.write_line(line)
  end
end

class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line "#{Time.new}: #{line}"
  end
end