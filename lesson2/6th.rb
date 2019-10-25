# Сумма покупок.
goods = Hash.new{}
goods_sum = Hash.new{}
to_pay = 0
loop do
  puts 'Введите название товара: '
  items = gets.chomp.to_sym
  break if items == :стоп

  puts 'Введите цену товара: '
  price = gets.chomp.to_f
  puts 'Введите количество товара: '
  count = gets.chomp.to_f
  goods[items] = { цена: price, количество: count }
  goods_sum[items] = price * count
  to_pay = goods_sum.values.sum
end
puts 'Наименование, цена за единицу, количество: ' "#{goods}"
puts 'Сумма по видам товаров: ' "#{goods_sum}"
puts 'К оплате: ' "#{to_pay}"
