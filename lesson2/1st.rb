months = {'Январь' => 31, 'Февраль' => 28,'Март'=> 31,'Апрель'=> 30,'Май'=> 31,'Июнь'=> 30, 'Июль'=> 31, 'Август'=> 31, 'Сентябрь'=> 30,'Октябрь'=> 31,'Ноябрь'=> 30,'Декабрь'=> 31}
months.each do |key,value|
if value == 30
puts "#{key}"
end
end 
