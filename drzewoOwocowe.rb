class Drzewo
	def initialize owoc
		@nazwa = owoc
		@wiek = 0
		@owoce = 0
		puts "Zasadzono #{@nazwa}"
	end
	def uplywaCzas
	@wiek +=1
		if @wiek>3
			@owoce += 10
		end
	end
	def czekaj
		puts "Pielęgnujesz #{@nazwa} cały rok"
		uplywaCzas
	end
	def zobacz
		puts "Na drzewie jest #{@owoce} owoców"
	end
	def zbierz
		if @owoce>0
			puts "Zrywasz jedno #{@nazwa} i jest pyszne!"
			@owoce -= 1
		else
			puts "Na drzewie nie ma #{@nazwa}"
			czekaj
		end
	end
	
end
puts "Jakie drzewo chcesz zasadzić?"
nazwa = gets.chomp
drzewo = Drzewo.new nazwa
puts "Co robisz: \"czekaj\", \"patrz\", \"bierz\":"
dzialanie = gets.chomp
while dzialanie != "zetnij"
	if dzialanie == "czekaj"
		drzewo.czekaj
		dzialanie = gets.chomp
	elsif dzialanie == "patrz"
		drzewo.zobacz
		dzialanie = gets.chomp
	elsif dzialanie == "bierz"
		drzewo.zbierz
		dzialanie = gets.chomp
	else 
		puts "Nie rozumiem"
		dzialanie = gets.chomp
	end
end
puts "Ściąłeś drzewo!"
koniec = gets.chomp







	
