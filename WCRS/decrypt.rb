require 'crypt/blowfish'

unless ARGV[0]
  puts "Sposób użycia: ruby decrypt.rb <S_nazwapliku.roz>"
  puts "Przykład: ruby decrypt.rb S_tajne.dane"
  exit
end

filename = ARGV[0].chomp
puts "Odszyfrowywanie #{filename}."
p = "O_#{filename}"

if File.exists?(p)
  puts "Plik już istnieje"
  exit
end

print 'Wpisz klucz szyfrujący: ' 
kee = $stdin.gets.chomp

begin
  blowfish = Crypt::Blowfish.new(kee)
  blowfish.decrypt_file(filename.to_s, p)
  puts 'Odszyfrowywanie zakończone sukcesem!'
rescue Exception => e
  puts "Wystąpił błąd w czasie odszyfrowywania: \n #{e}"
end