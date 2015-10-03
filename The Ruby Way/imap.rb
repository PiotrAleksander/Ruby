require 'net/imap'

host = "imap.hogwarts.edu"
user, pass = "lupi", "riddikulus"

imap = Net::IMAP.new(host)
begin
  imap.login(user, pass)
  #alternatywnie:
  #imap.authenticate("LOGIN", user, pass)
rescue Net::IMAP::NoResponseError
  abort "Logowanie jako #{user} zakończyło się niepowodzeniem."
end
#właściwe przetwarzanie...

imap.examine("INBOX") #tylko do odczytu. Dla usuwania lub innej edycji: Net::IMAP#select
total = imap.responses["EXISTS"].last #wszystkie wiadomości
recent = imap.responses["RECENT"].last #nieprzeczytane - liczba

imap.logout #przerwanie połączenia

imap.select("INBOX")

imap.create("lists")
imap.create("lists/ruby")
imap.create("lists/foobar")

imap.delete("lists/foobar")

msgs = imap.search("TO", "lupin")
msgs.each do |mid|
  env = imap.fetch(mid, "ENVELOPE")[0].attr["ENVELOPE"]
  puts "Od #{env.from[0].name}	#{env.subject}"
end