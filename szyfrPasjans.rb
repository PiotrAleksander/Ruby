def succ?(*a)
   begin
     (0..(a.size-2)).each {|i| return false if a[i].succ != a[i+1]}
     return true
   rescue
     return false
   end
end

class Talia
   def initialize
     @talia = (1..52).to_a + [:A, :B]
   end

   def ruch_a #A to pierwszy joker
     ruch_dol(@talia.index(:A))
   end

   def ruch_b
     ruch_dol(ruch_dol(@talia.index(:B)))
   end

   def ruch_dol(indeks)
     if indeks < 53
       nowy = indeks + 1
       @talia[nowy], @talia[indeks] = @talia[indeks], @talia[nowy]
     else
       @talia = @talia[0,1] + @talia[-1,1] + @talia[1..-2]
       nowy = 1
     end
     return nowy
   end

   def triple_cut #zamień karty leżące przed B z kartami leżącymi za A. Powinno być trójcięcie?
     jokery = [@talia.index(:A), @talia.index(:B)]
     szczyt, spod = jokery.min, jokery.max
     @talia = @talia[(spod+1)..-1] + @talia[szczyt..spod] + @talia[0...szczyt]
   end

   def wartosc(x)
     return 53 if x == :A or x == :B #Jokery mają jedną wartość, bo są używane jako kotwice przy rotacjach tailii.
     return x
   end

   def zlicz
     licznik = wartosc( @talia[-1] )
     @talia = @talia[licznik..-2] + @talia[0,licznik] + @talia[-1,1]
   end

   def wyjscie
     return @talia[ wartosc(@talia[0]) ]
   end

   def dostosuj
     ruch_a
     ruch_b
     triple_cut
     zlicz
   end

   def zbierz
     while true
       dostosuj
       c = wyjscie
       if c != :A and c != :B
         znak = ( ((c-1) % 26) + 65 ).chr
         return znak
       end
     end
   end

   def to_s
     a = []
     @talia.each_index {|i|
       if  succ?(a[-1], @talia[i], @talia[i+1])
         a << "..."
       elsif a[-1] == "..." and succ?(@talia[i-1], @talia[i], @talia[i+1])
       else
         a << @talia[i]
       end
     }
     return a.join(" ")
   end
end

class Enkryptor
   def initialize(smycz) #od przedmiotu na którym trzyma się klucze
     @smycz = smycz
   end

   def redakcja(s) #szyfrujemy tylko A-Z, duże litery przez konwencję karcianą.
     s = s.upcase
     s = s.gsub(/[^A-Z]/, "")
     s = s + "X" * ((5 - s.size % 5) % 5)
     w = ""
     (s.size / 5).times {|i| w << s[i*5,5] << " "}
     return w
   end

   def mod(c) #litery w alfabecie
     return c - 26 if c > 26
     return c + 26 if c < 1
     return c
   end

   def procesuj(s, &blok) #blok jako zewnętrzny silnik szyfrująco/deszyfrujący
     s = redakcja(s)
     w = ""
     s.each_byte { |c|
       if c >= ?A and c <= ?Z
         klucz = @smycz.zbierz
         kod = blok.call(c, klucz[0])
         w << kod.chr
       else
         w << c.chr
       end
     }
     return w
   end

   def szyfruj(s)
     return procesuj(s) {|c, klucz| 64 + mod(c + klucz - 128)}
   end

   def odszyfruj(s)
     return procesuj(s) {|c, klucz| 64 + mod(c -klucz)}
   end
end


def test
   d = Talia.new
   d.dostosuj
   puts d

   e = Enkryptor.new( Talia.new )
   szyfr =  e.szyfruj('Code in Ruby, live longer!') #przykład z RubyQuiz
   puts szyfr

   e = Enkryptor.new( Talia.new )
   puts e.odszyfruj(szyfr)
   print "\n"
   e = Enkryptor.new( Talia.new )
   puts e.odszyfruj("CLEPK HHNIY CFPWH FDFEH") #zadania sprawdzające poprawność z RubyQuiz

   e = Enkryptor.new( Talia.new )
   puts e.odszyfruj("ABVAW LWZSY OORYK DUPVH")
end

test
