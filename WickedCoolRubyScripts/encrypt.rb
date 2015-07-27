require 'crypt/blowfish'

unless ARGV[0]
  puts "Sposób użycia: ruby encrypt.rb <nazwapliku.roz>"
  puts "Przykład: ruby encrypt.rb tajne.dane"
  exit
end

filename = ARGV[0].chomp
puts filename
c = "S_#{filename}"

if File.exists?(c)
  puts "Plik już istnieje"
  exit
end

print 'Wpisz klucz szyfrujący (1-56 bajtów): '
kee = $stdin.gets.chomp

begin
  blowfish = Crypt::Blowfish.new(kee)
  blowfish.encrypt_file(filename.to_s, c)
  puts 'Szyfrowanie zakończone sukcesem!'
rescue Exception => e
  puts "W czasie szyfrowania wystąpił błąd: \n #{e}"
end