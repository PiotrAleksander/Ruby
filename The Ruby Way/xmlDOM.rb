require 'rexml/document'
include REXML

input = File.new('books.xml')
doc = Document.new(input)

root = doc.root
puts root.attributes["shelf"]

doc.elements.each("library/section") {|e| puts e.attributes["name"]}

doc.elements.each("*/section/book") {|e| puts e.attributes["isbn"]}

sec2 = root.elements[2]
author = sec2.elements[1].elements["author"].text
puts author