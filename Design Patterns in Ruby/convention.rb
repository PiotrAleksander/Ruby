require 'uri'
require 'net/smtp'
require 'net/http'

class Message
  attr_accessor :from, :to, :body
  
  def initialize(from, to, body)
    @from = from
	@to = URI.parse(to)
	@body = body
  end
end

class SmtpAdapter
  MailServerHost = 'localhost'
  MailServerPort = 25
  
  def send(message)
    from_address = message.from.user + '@' + message.from.host
	to_address = message.to.user + '@' + message.to.host
	
	email_text = "From: #{from_address}\n"
	email_text += "To:: #{to_address}\n"
	email_text += "Subject: Forwarded message\n"
	email_text += "\n"
	email_text += message.text
	
	Net::SMTP.start(MailServerHost, MailServerPort) do |smtp|
	  smtp.send_message(email_text, from_address, to_address)
	end
  end
end

class HttpAdapter
  def send(message)
    Net::HTTP.start(message.to.host, message.to.port) do |http|
	  http.post(message.to.path, message.text)
	end
  end
end

class FileAdapter
  def send(message)
    to_path = message.to.path
	to_path.slice!(0)
	
	File.open(to_path, 'w') do |f|
	  f.write(message.text)
	end
  end
end

class MessageGateway
  def initialize
    load_adapters
  end
  
  def process_message(message)
    adapter = adapter_for(message)
	adapter.send_message(message)
  end
  
  def adapter_for(message)
    protocol = message.to.scheme.downcase
    adapter_name = "#{protocol.capitalize}Adapter"
    adapter_class = self.class.const_get(adapter_name)
    adapter_class.new
  end
  
  def load_adapters
    lib_dir = File.dirname(__File__)
    full_pattern = File.join(lib_dir, 'adapter', '*.rb')
    Dir.glob(full_pattern).each {|file| require file}
  end
end

def camel_case(string)
  tokens = string.split('.')
  tokens.map! {|t| t.capitalize}
  tokens.join('Dot')
end

def authorizer_for(message)
  to_host = message.to.host || 'default'
  authorizer_class = camel_case(to_host) + "Authorizer"
  authorizer_class = self.class.const_get(authorizer_class)
  authorizer_class.new
end

def worm_case(string)
  tokens = string.spilt('.')
  tokens.map! {|t| t.downcase}
  tokens.join('_dot_')
end

def authorized?(message)
  authorizer = authorizer_for(message)
  user_method = worm_case(message.from) + '_authorized?'
  if authorizer.respond_to?(user_method)
    return authorizer.send(user_method, message)
  end
  authorizer.authorized?(message)
end