require 'net/http'
require 'thread'

class TrueRandom

  def initialize(min=nil, max=nil, buff=nil, slack=nil)
    @buffer = []
	@site = 'www.random.org'
	if ! defined? @init_flag
	  @min = min || 0
	  @max = max || 1
	  @bufsize = buff || 1000
	  @slacksize = slack || 300
	  @mutex = Mutex.new
	  @thread = Thread.new {fillbuffer}
	  @init_flag = TRUE
	else
	  @min = min || @min
	  @max = max || @max
	  @bufsize = buff || @bufsize
	  @slacksize = slack || @slacksize
	end
	@url = "/cgi-bin/randnum" + "?num=#@bufsize&min=#@min&max=#@max&col=1"
  end
  
  def fillbuffer
    h = Net::Http.new(@site, 80)
	resp, data = h.get(@url, nil)
	@buffer += data.split
  end
  
  def rand
    num = nil
	@mutex.synchronize {num = @buffer.shift}
	if @buffer.size < @slacksize
	  if ! @thread.alive?
	    @thread = Thread.new {fillbuffer}
	  end
	end
	if num == nil
	  if @thread.alive?
	    @thread.join
	  else
	    @thread = Thread.new {fillbuffer}
		@thread.join
	  end
	  @mutex.synchronize {num = @buffer.shift}
	end
	num.to_i
  end
end

t = TrueRandom.new(1, 6, 1000, 300)

count = {1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0}

1000.times do |n|
  x = t.rand
  count[x] += 1
end

p count