require_relative "xo/version"

module Xo
end

require_relative "./xo/kluczowe_rozszerzenie.rb"
lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/xo/**/*.rb"].each { |plik| require plik }