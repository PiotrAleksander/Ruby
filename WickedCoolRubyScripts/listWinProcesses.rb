require 'win32ole'

  ps = WIN32OLE.connect("winmgmts:\\\\.")
  ps.InstancesOf("win32_process").each do |p|
    puts "Proces: #{p.name}"
    puts "\tID: #{p.processid}"
    puts "\tŚCIEŻKA: #{p.executablepath}"
    puts "\tWĄTKI: #{p.threadcount}"
    puts "\tPRIORYTET: #{p.priority}"
    puts "\tARGUMENTY: #{p.commandline}"
  end