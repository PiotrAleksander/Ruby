require 'thread'

@music = Mutex.new
@violin = ConditionVariable.new
@bow = ConditionVariable.new

@violins_free = 2
@bows_free = 1

def musician(n)
  loop do
    sleep rand(0)
	@music.synchronize do
	  @violin.wait(@music) while @violins_free == 0
	  @violins_free -= 1
	  puts "#{n} dysponuje skrzypcami"
	  puts "liczba dostepnych skrzypiec #@violins_free; liczba dostepnych smyczkow #@bows_free"
	  
	  @bow.wait(@music) while @bows_free == 0
	  @bows_free -= 1
	  puts "#{n} dysponuje smyczkiem"
	  puts "liczba dostepnych skrzypiec #@violins_free; liczba dostepnych smyczkow #@bows_free"
	end
	
	sleep rand(0)
	puts "#{n}: (...gra...)"
	sleep rand(0)
	puts "#{n}: zakonczyl gre."
	
	@music.synchronize do
	  @violins_free += 1
	  @violin.signal if @violins_free == 1
	  @bows_free += 1
	  @bow.signal if @bows_free == 1
	end
  end
end

threads = []
3.times {|i| threads << Thread.new {musician(i)}}

threads.each {|t| t.join}