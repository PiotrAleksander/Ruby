
require 'cmath'
 
class Kwaternion #to rozwinięcie liczb zespolonych
 
        def initialize(a,b)
                @a,@b = a,b
        end
 
        def a
                @a
        end
 
        def b
                @b
        end
 #pars realis pars imaginaria
        def to_s
                '('+a.real.to_s+')+('+a.imag.to_s+')i+('+b.real.to_s+')j+('+b.imag.to_s+')k' 
        end
 
        def +(q)
                Kwaternion.new(@a+q.a,@b+q.b)
        end
 
        def -(q)
                Kwaternion.new(@a-q.a,@b-q.b)
        end
 
        def *(q)
                Kwaternion.new(@a*q.a-@b*q.b.conj,@a*q.b+@b*q.a.conj)
        end
 #hypotenuse to przeciwprostokątna, czyli tutaj wartość absolutna (dodatnia liczba rzeczywista)
        def abs
                Math.hypot(@a.abs,@b.abs) 
        end
 
        def conj #sprzężenie
                Kwaternion.new(@a.conj,-@b)
        end
 
        def /(q)
                d=q.abs**2
                Kwaternion.new((@a*q.a.conj+@b*q.b.conj)/d,(-@a*q.b+@b*q.a.conj)/d)
        end
 
end
puts "Z jakich części składać się będzie Kwaternion?:"
array = gets.chop