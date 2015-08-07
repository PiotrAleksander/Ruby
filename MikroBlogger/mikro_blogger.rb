require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MikroBlogger
  attr_reader :client

  def initialize
    print "Zainicjowano MikroBloggera\n"
	@client = JumpstartAuth.twitter #pierwsza inicjalizacja wysyła na stronę Twittera, gdzie autoryzujemy jumpstartlab.com i przepisujemy pin do konsoli
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h' #dzięki uprzejmości jumstartlab  
  end
  
  def tweet(tekst)
    #tekst.ljust(140) zrobi z wiadomości równo 140 znaków
	if tekst.length > 140
	  print "Wiadomość za długa.\n"
	else
      @client.update(tekst)
    end
  end
  
  def cw(cel, wiadomosc) #wiadomosc do celu(tylko spośród followers)
    nazwa_uzytk = @client.followers.collect { |follower| @client.user(follower).screen_name }
	if nazwa_uzytk.include? cel
	  print "Wysyłanie #{cel} wiadomości: "
      print wiadomosc
	  wiadomosc = "d @#{target} #{wiadomosc}" #syntax wymuszony przez API Twittera
      tweet(wiadomosc)
	else
	  print "Wiadomość można wysłać tylko jednemu ze swoich followers.\n"
	end
  end
    
  def lista_followers
    nazwa_uzytk = []
    @client.followers.each do |follower|
      nazwa_uzytk << @client.user(follower).screen_name
    end
    return nazwa_uzytk
  end
  
  def zaszynkuj_followers(wiadomosc) #wysyła wiadomość do wszystkich followers
    lista_followers.each do |follower|
      dm(follower, wiadomosc)
    end
  end
  
  def ostatnie_tweety #zwraca ostatnie tweety od followers
    znajomi = @client.friends #friends to property z API Tweetera
    znajomi.each do |znajomy|
	  czas =  @client.user(znajomy).created_at
	  print "#{czas.strftime("%A, %b %d")}\n"
      print @client.user(znajomy).screen_name 
      print @client.user(znajomy).status.text #status to złożony obiekt z własną metodą text
      print
    end
  end
  
  def skroc(oryginalny_url)
    print "Skracanie URL: #{oryginalny_url}\n"
    Bitly.use_api_version_3 #nie daję głowy, czy nie jest to przypadkiem domyślne ustawienie
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6') #login i hasło dzięki uprzejmości jumpstartlab
    skrot = bitly.shorten(oryginalny_url).short_url
    print skrot  
  end

  def klout #serwis do oceny wpływowości profilu społecznościowego
    znajomi = @client.friends.collect{|f| f.screen_name}
    znajomi.each do |znajomy|
      uzytk_id = Klout::Identity.find_by_screen_name(znajomy)# zbiera id znajomych
      print uzytk_id
	  uzytk = Klout::User.new(uzytk_id.id) #tworzy użytkownika według metody id
      print "#{uzytk.score.score}\n"
    end
  end
  
  def odpal
    komenda = ""
    while komenda != "q"
      printf "Wprowadź polecenie(q dla wyjścia): "
      wejscie = gets.chomp
      wejscie_czesci = wejscie.split(" ")
      komenda = wejscie_czesci[0]
      case komenda
        when 'q' then print "Do widzenia!\n"
        when 't' then tweet(wejscie_czesci[1..-1].join(" ")) #[0] to komenda; [1..n] to wiadomość, więc łączone spacjami
		when 'cw' then cw(wejscie_czesci[1], wejscie_czesci[2..-1].join(" ")) #[0] to komenda; [1] to adresat; [2..n] to wiadomość, więc łączone spacjami
		when 'spam' then spam_my_followers(wejscie_czesci[1..-1].join(" "))
        when 'ot' then ostatnie_tweety
		when 'skroc' then skroc(wejscie_czesci[1])
		when 'klout' then klout
        else
           print "Przykro mi, ale nie wiem jak: #{komenda}\n"
      end
    end
  end
end