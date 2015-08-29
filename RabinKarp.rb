require 'digest'

def RabinKarp(stog, igla)
  higla = Digest::MD5.hexdigest igla
  hstog = Digest::MD5.hexdigest stog[0..igla.length]

  for i in 1..stog.length-igla.length+1
    return i if higla == hstog and stog[i..i+igla.length-1] == igla
    hstog = Digest::MD5.hexdigest stog[i+1..i+igla.length]
  end

  return -1
end

puts RabinKarp('Tyle, ze za portal stories nie stoi wcale kondominium rosyjsko-niemieckie pod zydowskim zarzadem powierniczym, ale skupiona wokol Portala spolecznosc. Czuc zreszta, ze architekci nowych zagadek znaja komory, testowa aparature jak wlasna kieszen.', 'portal')
puts RabinKarp('something in the way she moves', 'she') 