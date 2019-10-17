#Заполнить массив числами фибоначчи до 100
a = 0
fb = [0, 1, 1]
until a > 100 do
  a = fb[-1] + fb[-2]
  fb.push(a) unless a > 100
end
puts fb
  