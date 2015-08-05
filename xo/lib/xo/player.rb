module Xo
  class Gracz
    attr_reader :kolor, :imie
    def initialize(wejscie)
      @kolor = wejscie.fetch(:kolor)
      @imie = wejscie.fetch(:imie)
    end
  end
end