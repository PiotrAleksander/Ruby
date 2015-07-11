def makler(ceny_akcji)
  dzien_kupna = 0
  dzien_sprzedazy = 0
  max_zysk = 1.0
  ceny_akcji.each_with_index do |cena_kupna, i|
    ceny_akcji[i+1..-1].each_with_index do |cena_sprzedazy, j|
      #puts "cena kupna: #{cena_kupna}, index #{i}, cena sprzedaży #{cena_sprzedazy}, index #{j}, zysk #{cena_sprzedazy-cena_kupna}"
      if(cena_sprzedazy - cena_kupna > max_zysk)
        max_zysk = cena_sprzedazy - cena_kupna
        dzien_kupna = i
        dzien_sprzedazy = j+i+1 #dni sprzedaży to dzień po dniu kupna[i] 
      end
    end
  end
  puts "najlepszy dzień na kupno: #{dzien_kupna+1} najlepszy dzień na sprzedaż: #{dzien_sprzedazy+1} z maksymalnym zyskiem: #{max_zysk}"
  return [(dzien_kupna+1), (dzien_sprzedazy+1)]
end

puts "Wprowadź ceny papierów wartościowych, ceny z kolejnych dni oddziel przecinkiem:"
ceny_uzytkownika = gets.chomp.split(',').map { |cena| cena.to_i }
puts makler(ceny_uzytkownika)