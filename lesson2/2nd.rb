#Заполнить массив из чисел 10-100  с шагом 5
a = []
(10..100).step(5) { |x| a.push(x) }
puts a
