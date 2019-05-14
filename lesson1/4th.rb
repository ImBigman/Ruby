puts "ах**2 + bx + c = 0"
puts "a= "
a = gets.chomp.to_f
puts "b= "
b = gets.chomp.to_f
puts "c= "
c = gets.chomp.to_f
D = b**2-(4*a*c)
if (D < 0)
  puts "Net resheniya"
end
if (D == 0) && a !=0
  puts "Один корень x = " + "#{-b/(2*a)}"
else (D > 0) && a !=0
  puts "Два значения: " +" "+ "Первое значение =" + " #{(-b - Math.sqrt(D))/(2*a)}" +" "+ "Второе значение = "+"#{(-b + Math.sqrt(D))/(2*a)}"
end
