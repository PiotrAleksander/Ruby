#Skrypt działa przeszukując serwer grupy dyskusyjnej pod kątem wyższych identyfikatorów komunikatu
#niż ostatni komunikat, który już wysłano za pomocą poczty elektronicznej.
#Jeżeli uda się takie artykuły odnaleźć, program odczyta je, wyśle ich zawartość na adres
#listy dyskusyjnej, po czym zarejestruje nowy najwyższy identyfikator wiadomości.
require 'nntp'
require 'net/smtp'
require 'params'

include NNTP

def send_mail(head, body)
  smtp = Net::SMTP.new
  smtp.start(Params::SMTP_SERVER)
  smtp.ready(Params::MAIL_SENDER, Params::MAILING_LIST) do |a|
    a.write head
	a.write "#{Params::LOOP_FLAG}\r\n"
	a.write "\r\n"
	a.write body
  end
end

#Rejestrujemy identyfikator ostatniego otrzymanego artykułu.

begin
  last_news = File.open(Params::LAST_NEWS_FILE) {|f| f.read}.to_i
rescue
  last_news = nil
end

#Nawiązujemu połączenie z serwerem grupy dyskusyjnej i odczytujemy
#bieżące numery wiadomości dla grupy comp.lang.ruby.
nntp = NNTPIO.new(Params::NEWS_SERVER)
raise "Próba nawiązania połączenia zakończyła się niepowodzeniem." unless nntp.connect
count, first, last = nntp.set_group(Params::NEWSGROUP)

if not last_news
  last_news = last
end

#Przechodzimy do ostatniego artykułu odczytanego poprzednim razem, po czym próbujemy
#odczytać ewentualne nowsze artykuły. Ta próba może się zakończyć wygenerowaniem
#wyjątku, jeśli użyty identyfikator dotyczy już nieistniejącego artykułu.

begin
  nntp.set_stat(last_news)
rescue
end

#Odczytujemy artykuły do chwili, w której wyczerpiemy
#dostępną pulę, i wysyłamy każdy z nich na listę dyskusyjną.

new_last = last_news
begin
  loop do
    nntp.set_next
	head = ""
	body = ""
	new_last = nntp.get_head do |line|
	  head << line
	end
	
	#Nie wysyłamy artykułów, które zostały już wysłane przez program mail2news
	#na adres danej grupy dyskusyjnej (w przeciwnym wypadku wpadlibyśmy w pętlę).
	next if head =~ %r{^X-rubymirror:}
	
	nntp.get_body do |line|
	  body << line
	end
	
	send_mail(head, body)
  end
rescue
end

#Rejestrujemy nowe informacje o stanie.

File.open(Params::LAST_NEWS_FILE, "w") do |f|
  f.puts new_last
end unless new_last == last_news