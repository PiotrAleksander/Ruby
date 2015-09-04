require 'find'
def findfiles(dir, name)
  list = []
  Find.find(dir) do |path|
    Find.prune if [".", ".."].include? path
    case name
    when String
      list << path if File.basename(path) == name
    when Regexp
      list << path if File.basename(path) =~ name
    else
      raise ArgumentError
    end
  end
  list
end