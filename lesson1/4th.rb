#Квадратное уравнение
puts "a*x**2 + b*x + c = 0"
puts "Укажите значение a: "
a = gets.chomp.to_f
puts "Укажите значение b: "
b = gets.chomp.to_f
puts "Укажите значение c: "
c = gets.chomp.to_f
D = b**2 - 4*a*c
if a == 0 
    puts "Это не квадратное уравнение, при а = 0"
else
 if D > 0 
    puts "Дискриминант равен #{D} первый корень: #{(-b + Math.sqrt(D))/2*a} , второй корень:#{(-b - Math.sqrt(D))/2*a} "
 elsif D == 0 
    puts "Дискриминант равен #{D} корень: #{-b/2*a}"
 else 
    puts "Корней нет"
 end
end