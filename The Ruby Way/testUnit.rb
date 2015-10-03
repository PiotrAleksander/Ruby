require 'test/unit'

class MyTest < Test::Unit::TestCase

  def self.major_setup
  #wykonywane przed każdym testem
  end
  
  def self.major_teardown
  #również wykonywane przed każdym testem
  end
  
  def self.suite
    mysuite = super
	
	def mysuite.run(*args)
	  MyTest.major_setup
	  super
	  MyTest.major_teardown
	end
	
	mysuite
  end
  
  def setup
  end
  
  def teardown
  end
  
  def test_001
  end
  
  def test_002
  end
end