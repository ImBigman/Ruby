#Идеальный вес
puts "Как вас зовут? :"
name = gets.chomp
puts "Какой у вас рост? :"
height = gets.chomp
if (height.to_i - 110) > 0
     puts "Ваш идеальный вес, #{name} : #{height.to_i - 110}" 
else 
    puts "Ваш вес уже оптимальный"
end