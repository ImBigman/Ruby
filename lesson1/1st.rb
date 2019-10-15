#Идеальный вес
puts "Как вас зовут? :"
name = gets.chomp.to_i
puts "Какой у вас рост? :"
height = gets.chomp.to_i
if (height - 110) > 0
  puts "Ваш идеальный вес, #{name} : #{height - 110}" 
else 
  puts "Ваш вес уже оптимальный"
end