#Месяцы с 30 днями
year = { "Январь" => 31, "Февраль" => 28, "Март" => 31, "Апрель" => 30, "Май" => 31, "Июнь" => 30, "Июль" => 31, "Август" => 31, "Сентябрь" => 30, "Октябрь" => 31, "Ноябрь" => 30, "Декабрь" => 31 }
year.each { |month, days| puts month if days == 30 }
