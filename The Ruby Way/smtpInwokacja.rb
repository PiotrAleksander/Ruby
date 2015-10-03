require 'net/smtp'

msg = <<EOF
Subject: Inwokacja
Litwo! Ojczyzno moja! Ty jesteś jak zdrowie,
Ile cię trzeba cenić, ten tylko się dowie,
Kto cię stracił. Dziś piękność twą w całej ozdobie
Widzę i opisuję, bo tęsknię po Tobie.
Panno święto, co Jasnej bronisz Częstochowy
I w Ostrej świecisz Bramie! Ty, co gród zamkowy
Nowogródzki ochraniasz z jego wiernym ludem!
EOF

Net::SMTP.start("smtp-server.fake.com") do |smtp|
  smtp.sendmail msg, 'walrus@fake1.com', 'alice@fake2.com'
end

msg = <<EOF
Subject: Logika
"Przeciwnie", ciągnął Tweedledee,
"jeżeli tak było, to mogło być;
a gdyby tak było, to mogłoby być;
ale, że tak nie jest, to nie jest.
To jest logika."
EOF

smtp = Net::SMTP.new("smtp-server.fake.com")
smtp.start
smtp.sendmail msg, 'tweedledee@fake1.com', 'alice@fake2.com'

msg = <<EOF
Subject: Moby Dick
Mów mi Ishmael.
EOF

addresses = ['reader1@fake2.com', 'reader2@fake3.com']

smtp = Net::SMTP.new("smtp-server.fake.com")
smtp.start do |obj|
  obj.sendmail msg, 'narrator@fake1.com', addresses
end

smtp = Net::SMTP.new("smtp-server.fake.com")

smtp.start

smtp.ready("a.mickiewicz@fake1.com", "reader@fake2.com") do |obj|
  obj.write "Litwo! Ojczyzno moja! Ty jesteś jak zdrowie,\r\n"
  obj.write "Ile cię trzeba cenić, ten tylko się dowie,\r\n"
  obj.write "Kto cię stracił.\r\n"
end

smtp.ready("a.mickiewicz@fake1.com", "reader@fake2.com") do |obj|
  obj << "Litwo! Ojczyzno moja! Ty jesteś jak zdrowie,\r\n"
  obj << "Ile cię trzeba cenić, ten tylko się dowie,\r\n"
  obj << "Kto cię stracił.\r\n"
end

class Net::NetPrivate::WriteAdapter
  def puts(args)
    args << "\r\n"
	self.write(*args)
  end
end

smtp.ready("a.mickiewicz@fake1.com", "reader@fake2.com") do |obj|
  obj.puts "Litwo! Ojczyzno moja! Ty jesteś jak zdrowie,\r\n"
  obj.puts "Ile cię trzeba cenić, ten tylko się dowie,\r\n"
  obj.puts "Kto cię stracił.\r\n"
end