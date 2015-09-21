module Tracing
  
  def Tracing.included(into)
    into.instance_methods(false).each {|m| Tracing.hook_method(into,m)}
    def into.method_added(meth)
      unless @adding
        @adding = true
        Tracing.hook_method(self, meth)
        @adding = false
      end
    end
  end
  
  def Tracing.hook_method(klass, meth)
    klass.class_eval do
      alias_method :"old_#{meth}", :"#{meth}"
      define_method(meth) do |*args|
        puts "Wywołano metodę #{meth}. Parametry: #{args.join(', ')}"
        self.send("old_#{meth}", *args)
      end
    end
  end
end

class MyClass
  include Tracing
  
  def first_meth
  end
  
  def second_meth(x, y)
  end
end

m = MyClass.new
puts m.first_meth
puts m.second_meth(1, 'kot')