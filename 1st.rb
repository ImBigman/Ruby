puts "Пожалуйста, укажите свое имя:"
name = gets.chomp
puts "Укажите свой рост:"
height = gets.chomp.to_i
puts "Ваш идеальный вес: " + " " + "#{height - 110}"
