class Osoba
  attr_reader :imie, :nazwisko, :email
  attr_accessor :santa

  def initialize(linia)
    m = /(\S+)\s+(\S+)\s+<(.*)>/.match(linia)
    raise unless m
    @imie = m[1].capitalize
    @nazwisko = m[2].capitalize
    @email = m[3]
  end

  def nie_jest_rodzina?(other)
    @nazwisko != other.nazwisko
  end
end

wejscie = "Luke Skywalker <luke@theforce.net>
Leia Skywalker <leia@therebellion.org>
Toula Portokalos <toula@manhunter.org>
Gus Portokalos <gus@weareallfruit.net>
Bruce Wayne <bruce@imbatman.com>
Virgil Brigman <virgil@rigworkersunion.org>
Lindsey Brigman <lindsey@iseealiens.net>"



grupa = []
wejscie.each_line do |linia|
  linia.strip!
  grupa << Osoba.new(linia) unless linia.empty?
end

santas = grupa.dup
grupa.each do |osoba|
  osoba.santa = santas.delete_at(rand(santas.size))
end

grupa.each do |osoba|
  unless osoba.santa.nie_jest_rodzina? osoba
    kandydaci = grupa.select { |p|
    p.santa.nie_jest_rodzina?(osoba) &&
    osoba.santa.nie_jest_rodzina?(p)
    }
  raise if kandydaci.empty?
    other = kandydaci[rand(kandydaci.size)]
    temp = osoba.santa
    osoba.santa = other.santa
    other.santa = temp
    koniec = false
  end
end

grupa.each do |osoba|
  printf "%s %s -> %s %s\n", osoba.santa.imie, osoba.santa.nazwisko, osoba.imie, osoba.nazwisko
end
