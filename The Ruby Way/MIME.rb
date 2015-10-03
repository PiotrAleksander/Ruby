require 'net/smtp'

def text_plus_attachment(subject, body, filename)
  marker = "MIME_boundary"
  middle = "--#{marker}\n"
  ending = "--#{middle}--\n"
  content = "Content-Type: Multipart/Related; " +
				"boundary=#{marker}; " +
				"typw=text/plain"
  head1 = <<-EOF
MIME-Version: 1.0
#{content}
Subject: #{subject}
  EOF
  binary = File.read(filename)
  encoded = [binary].pack("m")
  head2 <<EOF
Content-Description: "#{filename}"
Content-Type: image/gif; name="#{filename}"
Content-Transfer-Encoding: Base64
Content-Disposition: attachment; filename="#{filename}"

EOF

  head1 + middle + body + middle + head2 + encoded + ending
end

domain = "someserver.com"
smtp = "smtp.#{domain}"
user, pass = "elgar", "enigma"

body = <<EOF
To jest moja wiadomość. Nie mam
zbyt wiele do napisania. Załaczyłem
bardzo mały plik GIF.

	-- Piotr
EOF
mailtext = text_plus_attachment("Witaj...", body, "new.gif")

Net::SMTP.start(smtp, 25, domain, user, pass, :plain) do |mailer|
  mailer.sendmail(mailtext, 'fromthisguy@wherever.com', ['destination@elsewhere.com'])
end