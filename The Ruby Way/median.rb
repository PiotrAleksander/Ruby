def median(x)
  sorted = x.sort
  mid = x.size/2
  sorted[mid]
end

data = [7,7,7,4,4,5,4,4,5,7,2,2,3,3,7,3,4]

p median(data)