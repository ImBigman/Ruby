#Прямоугольный теругольник
puts "Укажите длинну первой стороны треугольника: "
a = gets.chomp.to_f
puts "Укажите длинну второой стороны треугольника: "
b = gets.chomp.to_f
puts "Укажите длинну третьей стороны треугольника: "
c = gets.chomp.to_f
sorter = [a, b, c].sort
qdr = sorter[2]**2 == sorter[0]**2 + sorter[1]**2
if sorter[2] > sorter[0] + sorter[1] || sorter.include?(nil) || sorter.include?(0) 
  puts "Треугольник не существует"
elsif qdr  && (a == b || b == c || a == c)
  puts "Треугольник прямоугольный и равнобедренный"
elsif qdr
  puts "Треугольник прямоугольный"
else 
  puts "Треугольник не прямоугольный"
end
if a == b && b == c && c != 0 
  puts "Треугольник равносторонний"
end
if (a == b || b == c || a == c) && (a != b || b != c || a != c)
  puts "но равнобедренный"  
end