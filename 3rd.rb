puts "Первая сторона: "
a = gets.chomp.to_f
puts "Вторая сторона: "
b = gets.chomp.to_f
puts "Третья сторона: "
c = gets.chomp.to_f
if (a**2 + b**2 == c**2 || b**2 + c**2 == a**2 || c**2 +a**2 == b**2) && (a == b || b == c || a == c)
puts "Pryamougolniy  i ravnobedrenniy"
elsif a**2 + b**2 == c**2 || b**2 + c**2 == a**2 || c**2 +a**2 == b**2
  puts "Pryamougolniy"
else puts "Ne pryamougolniy"
end
if a == b && b == c
  puts "No ravnosotoronniy"
end
