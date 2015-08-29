require 'zlib'
include Zlib

string = ("abcde"*71+"defghi"*79+"ghijkl"*113)*371
p string.length
s1 = Deflate.deflate(string, BEST_SPEED)
p s1.length
s2 = Deflate.deflate(string)
p s2.length
s3 = Deflate.deflate(string, BEST_COMPRESSION)
p s3.length
