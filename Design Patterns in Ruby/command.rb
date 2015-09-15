require 'fileutils'

class Command
  attr_reader :description
  
  def initialize(description)
    @description = description
  end
  
  def execute
  end
end

class CreateFile < Command
  def initialize(path, contents)
    super("Tworzenie pliku #{path}")
	@path = path
	@contents = contents
  end
  
  def execute
    f = File.open(@path, "w")
	f.write(@contents)
	f.close
  end
  
  def unexecute
    File.delete(@path)
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Usuwanie pliku #{path}")
	@path = path
  end
  
  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
	end
	f = File.delete(@path)
  end
  
  def unexecute
    if @contents
	  f = File.open(@path, "w")
	  f.write(@contents)
	  f.close
	end
  end
end

class CopyFile < Command
  def initialize(source, target)
    super("Kopiowanie pliku #{source} do pliku #{target}")
	@source = source
	@target = target
  end
  
  def execute
    FileUtils.copy(@source, @target)
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end
  
  def add_command(cmd)
    @commands << cmd
  end
  
  def execute
    @commands.each {|cmd| cmd.execute}
  end
  
  def unexecute
    @commands.reverse_each {|cmd| cmd.unexecute}
  end
  
  def description
    description = ''
	@commands.each {|cmd| description+= cmd.description + "\n"}
	description
  end
end

cmds = CompositeCommand.new

cmds.add_command(CreateFile.new('file1.txt', "witaj swiecie\n"))
cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add_command(DeleteFile.new('file1.txt'))
puts cmds.description
cmds.execute
