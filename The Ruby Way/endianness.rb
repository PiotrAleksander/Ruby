def endianness
  num=0x12345678
  little = "78563412"
  big = "12345678"
  native = [num].pack('l')
  netunpack = native.unpack('N')[0]
  str = "%8x" % netunpack
  case str
    when little
	  "ARCHITEKTURA CIENKOKOŃCOWA"
	when big
	  "ARCHITEKTURA GRUBOKAŃCOWA"
	else
	  "INNA ARCHITEKTURA"
  end
end

puts endianness