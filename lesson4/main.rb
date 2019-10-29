require_relative '../lesson4/cargo_train'
require_relative '../lesson4/passenger_train'
require_relative '../lesson4/route'
require_relative '../lesson4/station'
require_relative '../lesson4/train'
require_relative '../lesson4/cargo_carriage'
require_relative '../lesson4/passenger_carriage'

@station_list = []
@route_list = []
@train_list = []
@carriages_list = []

def main
puts 'Для того чтобы выполнить операцию укажите номер одного из пунктов: '
puts '1 - Создать станцию'
puts '2 - Создать поезд'
puts '3 - Создать маршруты и управлять станциями в нем (добавлять, удалять)'
puts '4 - Назначить маршрут поезду'
puts '5 - Добавлять вагоны к поезду'
puts '6 - Отцеплять вагоны от поезда'
puts '7 - Перемещать поезд по маршруту вперед и назад'
puts '8 - Просматривать список станций и список поездов на станции'
puts '9 - Выход'
end

def create_station
  puts 'Введите название станции: '
  name = gets.chomp
  @station_list.push(Station.new(name))
  puts "Вы создали станцию:  #{name} "
end

def create_train
  puts 'Введите название поезда: '
  number = gets.chomp
  puts "Выберите тип поезда: 1 'Грузовой' 2 'Пассажирский'"
  kind = gets.chomp
  @t1 = if kind == 1
          CargoTrain.new(number)
        else
          PassengerTrain.new(number)
        end
  @train_list.push(@t1)
  puts "Вы создали #{@t1.kind} поезд: #{@t1.number} "
end

def create_route
  puts 'Введите первую станцию в маршруте: '
  first_station = gets.chomp
  puts 'Введите последнюю станцию в маршруте: '
  end_station = gets.chomp
  @r1 = Route.new(first_station, end_station)
  puts "Вы создали маршрут #{@r1.full_route}"
  @route_list.push(@r1)
end

def adjust_route
  puts 'Выберите маршрут для редактирования из списка: '
  p @route_list
  @route_number = gets.chomp.to_i
  b = @route_list[@route_number - 1]
  puts "Если хотите управлять маршрутом:
     1 'Добавить станцию в маршрут'
     2 'Удалить станцию из маршрута'
     3 'Пропустить'"
  adjust = gets.chomp
  case adjust
  when '1'
    puts 'Выберите станцию, которую нужно добавить к маршруту: '
    p @station_list
    @station_in_list = gets.chomp.to_i
    a = @station_list[@station_in_list - 1]
    b.route_station_add(a)
    puts "Вы добавили #{a.name} к маршруту.  #{b.full_route}"
  when '2'
    p b.full_route
    puts 'Выберите станцию, которую нужно удалить из маршрута: '
    @station_in_route = gets.chomp.to_i
    c = b.full_route[@station_in_route - 1]
    b.route_station_remove(c)
    puts "Вы удалили #{c.name} из маршрута.  #{b.full_route}"
  else puts 'выход'
  end
end

def train_add_route
  puts 'Выберите поезд, которому нужно добавить маршрут: '
  p @train_list
  @train_in_list = gets.chomp.to_i
  a = @train_list[@train_in_list - 1]
  puts 'Выберите маршрут для поезда из списка: '
  p @route_list
  @route_number = gets.chomp.to_i
  b = @route_list[@route_number - 1]
  a.add_route(b)
  p a
end

def tack_carriage
  puts 'Выберите поезд, к которому нужно добавить вагон: '
  p @train_list
  @train_in_list = gets.chomp.to_i
  a = @train_list[@train_in_list - 1]
  a.stop
  p 'Укажите номер вагона'
  carriage_name = gets.chomp
  @new_carriage = if a.kind == 'Грузовой'
                    CargoCarriage.new(carriage_name)
                  else
                    PassengerCarriage.new(carriage_name)
                  end
  a.carriages_add(@new_carriage)
  p "Вы добавили вагон  #{@new_carriage.name} к поезду  #{a.number}"
  p 'Всего вагонов: ' "#{a.carriages_count}"  '  список  ' " #{a.carriages_pull}"
end

def unhook_carriage
  puts 'Выберите поезд, у которого нужно отцепить вагон: '
  p @train_list
  @train_in_list = gets.chomp.to_i
  a = @train_list[@train_in_list - 1]
  a.stop
  p a.carriages_pull
  p 'Укажите порядковый номер вагона'
  @carriage_num = gets.chomp.to_i
  b = a.carriages_pull[@carriage_num - 1]
  a.carriages_remove(b)
  p "Вы удалили вагон от поезда  #{a.number}"
  p 'Всего вагонов: ' "#{a.carriages_count}" '  список  ' " #{a.carriages_pull}"
end

def train_moving
end

def station_explorer
end

def again
  main
  @main_menu = gets.chomp
  your_choice
end

def your_choice
  case @main_menu
  when '1'
    create_station
    p @station_list
    p "Всего станций: #{@station_list.count}"
    again
  when '2'
    create_train
    p @train_list
    p "Всего поездов: #{@train_list.count}"
    again
  when '3'
    p " 1 - 'Создать' 2 - 'Редактировать'"
    @route_action = gets.chomp
    case @route_action
    when '1'
      create_route
      p @route_list
      p "Всего маршрутов: #{@route_list.count}"
    when '2'
      adjust_route
      p @route_list
    end
    again
  when '4'
    train_add_route
    again
  when '5'
    tack_carriage
    again
  when '6'
    unhook_carriage
    again
  when '7'
    train_moving
    again
  when '8'
    station_explorer
    again
  when '9'
    p  'До свидания :)'
    exit(true)
  else
    again
  end
end
main
@main_menu = gets.chomp
your_choice
exit(true )
