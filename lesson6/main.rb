require_relative '../lesson6/cargo_train'
require_relative '../lesson6/passenger_train'
require_relative '../lesson6/route'
require_relative '../lesson6/station'
require_relative '../lesson6/train'
require_relative '../lesson6/cargo_carriage'
require_relative '../lesson6/passenger_carriage'

class Main
  def initialize
    @station_list = []
    @route_list = []
    @train_list = []
  end

  def menu
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
    main_menu = gets.chomp
    case main_menu
    when '1'
      create_station
      menu
    when '2'
      create_train
      menu
    when '3'
      route_menu
      menu
    when '4'
      train_add_route
      menu
    when '5'
      tack_carriage
      menu
    when '6'
      unhook_carriage
      menu
    when '7'
      train_moving
      menu
    when '8'
      station_explorer
      menu
    when '9'
      puts  'До свидания.'
      exit(true)
    else
      exit
    end
  end

  protected

  def create_station
    puts 'Введите название станции (русскими буквами с заглавной): '
    name = gets.chomp
    @station_list.push(Station.new(name))
    puts "Вы создали станцию:  #{name} "
    p @station_list
    p "Всего станций: #{@station_list.count}"
  end

  def create_train
    puts 'Введите номер поезда (формат 3 буквы/цифры в любом порядке, необязательный дефис  и еще 2 буквы/цифры): '
    number = gets.chomp
    puts "Выберите тип поезда: 1 'Грузовой' 2 'Пассажирский'"
    kind = gets.chomp.to_i
    train = if kind == 1
              CargoTrain.new(number)
            else
              PassengerTrain.new(number)
            end
    @train_list.push(train)
    puts "Вы создали #{train.kind} поезд: #{train.number} "
    p @train_list
    p "Всего поездов: #{@train_list.count}"
  rescue ArgumentError => e
    p "Ошибка c:  #{e.message}"
    p 'Вы ввели не верный формат номера! Попробуйте еще раз.'
    retry
  end

  def route_menu
    p " 1 - 'Создать' 2 - 'Редактировать' "
    route_action = gets.chomp
    case route_action
    when '1'
      create_route
    when '2'
      adjust_route
    else p 'Назад в меню'
    end
    menu
  end

  def create_route
    p @station_list
    puts 'Выберите начальную станцию в маршруте: '
    first = gets.chomp.to_i
    first_station = @station_list[first - 1]
    puts 'Выберите конечную станцию в маршруте: '
    end_station = gets.chomp.to_i
    end_station = @station_list[end_station - 1]
    route = Route.new(first_station, end_station)
    puts "Вы создали маршрут #{route.full_route}"
    @route_list.push(route)
    p @route_list
    p "Всего маршрутов: #{@route_list.count}"
  end

  def adjust_route
    puts 'Выберите маршрут для редактирования из списка: '
    p @route_list
    route_number = gets.chomp.to_i
    route = @route_list[route_number - 1]
    puts "Управление маршрутом:
       1 'Добавить станцию в маршрут'
       2 'Удалить станцию из маршрута'
       3 'Пропустить'"
    adjust = gets.chomp
    case adjust
    when '1'
      puts 'Выберите станцию, которую нужно добавить к маршруту: '
      p @station_list
      station_in_list = gets.chomp.to_i
      station = @station_list[station_in_list - 1]
      route.route_station_add(station)
      puts "Вы добавили #{station.name} к маршруту.  #{route.full_route}"
      p @route_list
    when '2'
      p route.full_route
      puts 'Выберите станцию, которую нужно удалить из маршрута: '
      station_in_route = gets.chomp.to_i
      station = route.full_route[station_in_route - 1]
      route.route_station_remove(station)
      puts "Вы удалили #{station.name} из маршрута.  #{route.full_route}"
      p @route_list
    else puts 'выход'
    end
  end

  def train_add_route
    puts 'Выберите поезд, которому нужно добавить маршрут: '
    p @train_list
    train_in_list = gets.chomp.to_i
    train = @train_list[train_in_list - 1]
    puts 'Выберите маршрут для поезда из списка: '
    p @route_list
    route_number = gets.chomp.to_i
    route = @route_list[route_number - 1]
    train.add_route(route)
    p train
  end

  def tack_carriage
    puts 'Выберите поезд, к которому нужно добавить вагон: '
    p @train_list
    train_in_list = gets.chomp.to_i
    train = @train_list[train_in_list - 1]
    train.stop
    p 'Укажите номер вагона (русскими буквами с заглавной): '
    carriage_name = gets.chomp
    new_carriage = if train.kind == 'Грузовой'
                     CargoCarriage.new(carriage_name)
                   else
                     PassengerCarriage.new(carriage_name)
                   end
    train.carriages_add(new_carriage)
    p "Вы добавили вагон  #{new_carriage.name} к поезду  #{train.number}"
    p 'Всего вагонов: ' "#{train.carriages_count}"  '  список  ' " #{train.carriages_pull}"
  end

  def unhook_carriage
    puts 'Выберите поезд, у которого нужно отцепить вагон: '
    p @train_list
    train_in_list = gets.chomp.to_i
    train = @train_list[train_in_list - 1]
    train.stop
    p train.carriages_pull
    p 'Укажите порядковый номер вагона'
    carriage_num = gets.chomp.to_i
    carriage = train.carriages_pull[carriage_num - 1]
    train.carriages_remove(carriage)
    p "Вы удалили вагон от поезда  #{train.number}"
    p 'Всего вагонов: ' "#{train.carriages_count}" '  список  ' " #{train.carriages_pull}"
  end

  def train_moving
    puts 'Выберите поезд, который нужно переместить: '
    p @train_list
    train_in_list = gets.chomp.to_i
    train = @train_list[train_in_list - 1]
    train.faster(60)
    p "Переместить: 1 - 'Вперед' 2 - 'Назад' "
    course = gets.chomp
    case course
    when '1'
      train.forward_on_route
    else train.back_on_route
    end
    p "Текущая станция поезда на маршруте:  #{train.current_station.name}"
    p "Весь маршрут:  #{train.route.full_route}"
  end

  def station_explorer
    puts "Полный список станций:  #{@station_list}"
    puts 'Выберите станцию, которую нужно просмотреть: '
    station_in_list = gets.chomp.to_i
    station = @station_list[station_in_list - 1]
    puts "Вы выбрали станцию: #{station.name}"
    p "Список поездов на станции: #{station.station_pull_kind}"
    p "Всего поездов на станции: #{station.station_pull.count}"
  end
end

ui = Main.new
ui.menu