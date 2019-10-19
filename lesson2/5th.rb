#5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
#Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть
#високосным.
years_days = {
  'Январь' => 31, 'Февраль' => 28, 'Март' => 31,
  'Апрель' => 30, 'Май' => 31, 'Июнь' => 30,
  'Июль' => 31, 'Август' => 31, 'Сентябрь' => 30,
  'Октябрь' => 31, 'Ноябрь' => 30, 'Декабрь' => 31
 }
puts 'Введите число своего дня рождения:  '
day = gets.chomp.to_i
puts 'Введите число месяца своего рождения:  '
month = gets.chomp.to_i
puts 'Введите год своего рождения:  '
year = gets.chomp.to_i
if year % 4 == 0 || year % 400 == 0
  years_days['Февраль'] = 29
elsif year % 100 == 0
  puts 'не високосный 28'
end
answer = years_days.take(month - 1).to_h.sum { |n, d| d } + day
puts 'Прядковый номер даты рождения: ' "#{answer}"
