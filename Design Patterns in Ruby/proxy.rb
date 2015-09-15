require 'etc'

class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance=0)
    @balance = starting_balance
  end
  
  def deposit(amount)
    @balance += amount
  end
  
  def withdraw(amount)
    @balance -= amount
  end
end

class BankAccountProxy
  
  def initialize(real_object)
    @real_object = real_object
  end
  
  def balance
    @real_object.balance
  end
  
  def deposit(amount)
    @real_object.deposit(amount)
  end
  
  def withdraw(amount)
    @real_object.withdraw(amount)
  end
end

class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
	@owner_name = owner_name
  end
  
  def method_missing(name, *args)
    check_access
	@subject.send(name, *args)
  end
  
  def check_access
    if Etc.getlogin != @owner_name
	  raise "Błąd dostępu: #{Etc.getlogin} nie ma dostępu do rachunku."
	end
  end
end

class VirtualAccountProxy
  
  def initialize(&creation_block)
    @creation_block=creation_block
  end
  
  def deposit(amount)
    s = subject
	return s.deposit(amount)
  end
  
  def withdraw(amount)
    s = subject
	return s.withdraw(amount)
  end
  
  def balance
    s = subject
	return s.balance
  end
  
  def subject
    @subject || @subject = @creation_block.call
  end
end

class AccountProxy
  def initialize(real_account)
    @subject = real_account
  end
  
  def method_missing(name, *args)
    puts "Delegacja komunikatu #{name} do tematu."
	@subject.send(name, *args)
  end
end

class VirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block 
  end
  
  def method_missing(name, *args)
    s = subject
	s.send(name, *args)
  end
  
  def subject
    @subject || @subject = @creation_block.call
  end
end