require 'cgi'

def reverse_ramblings(ramblings)
  if ramblings[0] == nil then return " " end
  chunks = ramblings[0].split(/\s+/)
  chunks.reverse.join(" ")
end

cgi = CGI.new("html4")
cgi.out do
  cgi.html do
    cgi.body do
	  cgi.h1 {"sdrawkcaB txeT"} +
	  cgi.b {reverse_ramblings(cgi['ramblings'])} +
	  cgi.form("action" => "/cgi-bin/rb/form.cgi") do
	    cgi.textarea("ramblings") {cgi['ramblings']} + cgi.submit
	  end
	end
  end
end