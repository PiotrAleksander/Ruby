# == Opis programu
#
#  fileSecurity.rb: szyfruje i odszyfrowuje pliki; ilustruje działanie Blowfish: bardzo szybkiego symetrycznego szyfru blokowego
#
#
# == Sposób użycia
#
#  szyfrowanie [OPCJE] ... PLIK
#
# -h, --help:
#  Wyświetla pomoc
#
# --encrypt klucz, -d klucz
#  Szyfruje plik przy użyciu hasła
#
# --decrypt klucz, -d klucz
#  Odszyfrowuje plik przy użyciu hasła
#
#  PLIK: Plik, który chcesz zaszyfrować lub odszyfrować

require 'getoptlong'
require 'rdoc/ri/paths'
require 'rdoc/rdoc'
require 'crypt/blowfish'

def encrypt(file, pass)
  c = "Z_#{file}"
  if File.exists?(c)
    puts "\nPlik już istnieje."
	exit
  end
  
  begin
    # Inicjowanie metody szyfrującej przy użyciu klucza podanego przez użytkownika.
	blowfish = Crypt::Blowfish.new(pass)
	blowfish.encrypt_file(file.to_s, c)
	# Szyfrowanie pliku.
	puts "\nSzyfrowanie zakończone sukcesem!"
  rescue Exception => e
    puts "W czasie szyfrowania wystąpił błąd: \n #{e}"
  end
end

def decrypt(file, pass)
  p = "O_#{file}"
  
  if File.exists?(p)
    puts "\nPlik już istnieje"
  end

  begin
    # Inicjowanie metody odszyfrowującej przy użyciu klucza podanego przez użytkownika.
    blowfish = Crypt::Blowfish.new(pass)
    blowfish.decrypt_file(file.to_s, p)
    # Odszyfrowywanie pliku.
    puts "\nOdszyfrowywanie zakończone sukcesem!"
  rescue Exception => e
    puts "W czasie odszyfrowywania wystąpił błąd: \n #{e}"
  end
end

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ], 
  [ '--szyfruj', '-s', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--odszyfruj', '-o', GetoptLong::REQUIRED_ARGUMENT]
  )  

unless ARGV[0]
  puts "\nNie podano nazwy pliku (wypróbuj: ruby fileSecurity.rb --help)"
  exit
end

filename = ARGV[-1].chomp

opts.each do |opt, arg|
  case opt
  when '--help'
    rdoc = RDoc::RDoc.new
	options = rdoc.load_options
    rdoc.document options
  when '--szyfruj'
    encrypt(filename, arg)
  when '--odszyfruj'
    decrypt(filename, arg)
  else
    rdoc = RDoc::RDoc.new
	options = rdoc.load_options
    rdoc.document options
  end
end
    