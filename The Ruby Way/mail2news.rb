#mail2news: Otrzymuje wiadomość mailową i przekazuje ją w formie nowego wpisu grupy dyskusyjnej.
require 'nntp'
include NNTP

require 'params'

HEADERS = %w{From Subject References Message-ID Content-Type Content-Transfer-Encoding Date}

allowed_headers = Regexp.new(%{^(#{HEADERS.join("|")}):})

head = "Grupa dyskusyjna: #{Params::NEWSGROUP}\n"
subject = "nieznany"
while line = gets
  exit if line =~ /^#{Params::LOOP_FLAG}/o
  break if line =~ /^\s*$/
  next if line =~ /^\s/
  next unless line =~ allowed_headers
  
  #Usuwa z tematu przedrostek [ruby-talk:nnnn] przed jego przekazaniem
  #do grupy dyskusyjnej.
  if line =~ /^Subject:\s*(.*)/
    subject = $1
	
	#Usuwa specjalny numer ruby-talk
	#z początku wiadomości listy dyskusyjnej przed ich 
	#przekazaniem na serwer grupy dyskusyjnej.
	line.sub!(/\[ruby-talk:(\d+)\]\s*/, "")
	subject = "[#$1] #{line}"
	head << "X-ruby-talk: #$1\n"
  end
  head << line
end

head << "#{Params::LOOP_FLAG}\n"

body = ""
while line = gets
  body << line
end

msg = head + "\n" + body
msg.gsub!(/\r?\n/, "\r\n")

nntp = NNTPIO.new(Params::NEWS_SERVER)
raise "Próba nawiązania połączenia zakończyła się niepowodzeniem." unless nntp.connect
nntp.post(msg)