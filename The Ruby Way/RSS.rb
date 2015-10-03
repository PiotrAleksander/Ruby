require 'rss'

feed = RSS::Rss.new("2.0")

chan = RSS::Rss::Channel.new
chan.description = "Nasz pierwszy kanał RSS"
chan.link = "http://nosuchplace.org/home"

img = RSS::Rss::Channel::Image.new
img.url = "http://nosuchplace.org/images/headshot.jpg"
img.title = "Y.T."
img.link = chan.link

chan.image = img
feed.channel = chan

i1 = RSS::Rss::Channel::Item.new
i1.title = "To znowu my!"
i1.link = "http://nosuchplace.org/articles/once_again/"
i1.description = "Nie czujesz się teraz jak ktoś wyjątkowy?"

i2 = RSS::Rss::Channel::Item.new
i2.title = "Jeszcze się trzymamy, dziękujemy za zainteresowanie."
i2.link = "http://nosuchplace.org/articles/thanks/"
i2.description = "Naprawdę tęsknię za czasami, kiedy nasze łącze było przeciążone..."

i3 = RSS::Rss::Channel::Item.new
i3.title = "Czy ktoś nas słyszy?"
i3.link = "http://nosuchplace.org/articles/hello/"
i3.description = "To niemożliwe, żeby tak atrakcyjny kanał nie znalazł odbiorców."

feed.channel.items << i1 << i2 << i3

puts feed