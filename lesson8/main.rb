require_relative '../lesson8/cargo_train'
require_relative '../lesson8/passenger_train'
require_relative '../lesson8/route'
require_relative '../lesson8/station'
require_relative '../lesson8/train'
require_relative '../lesson8/cargo_carriage'
require_relative '../lesson8/passenger_carriage'
# rubocop: disable Metrics/ClassLength
class Main
  def initialize
    @station_list = []
    @route_list = []
    @train_list = []
  end

  # rubocop: disable Metrics/CyclomaticComplexity
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def menu
    puts 'Для того чтобы выполнить операцию укажите номер одного из пунктов: '
    puts '1 - Создать станцию'
    puts '2 - Создать поезд'
    puts '3 - Создать маршруты и управлять станциями в нем (добавлять, удалять)'
    puts '4 - Назначить маршрут поезду'
    puts '5 - Добавлять вагоны к поезду'
    puts '6 - Отцеплять вагоны от поезда'
    puts '7 - Занять место/объем в вагоне поезда'
    puts '8 - Перемещать поезд по маршруту вперед и назад'
    puts '9 - Просматривать список станций и список поездов на станции'
    puts '10 - Просматривать список вагонов поезда и их вместимость'
    puts '11 - Выход'
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
      engage_carriage
      menu
    when '8'
      train_moving
      menu
    when '9'
      station_explorer
      menu
    when '10'
      train_explorer
      menu
    when '11'
      puts  'До свидания.'
      exit(true)
    else
      exit
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/CyclomaticComplexity

  protected

  def create_station
    puts 'Введите название станции (русскими буквами с заглавной): '
    name = gets.chomp
    @station_list.push(Station.new(name))
    puts "Вы создали станцию:  #{name} "
    p @station_list.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    p "Всего станций: #{@station_list.count}"
  end

  def route_menu
    p '1 - Создать  2 - Редактировать'
    route_action = gets.chomp.to_i
    if route_action == 1
      create_route
    elsif route_action == 2
      adjust_route
    end
    menu
  end

  def train_moving
    puts 'Выберите поезд, который нужно переместить: '
    train_selector
    @train.faster(30)
    p "Переместить: 1 - 'Вперед' 2 - 'Назад' "
    course = gets.chomp
    course == '1' ? @train.forward_on_route : @train.back_on_route
    p "Текущая станция поезда на маршруте:  #{@train.current_station.name}"
    p "Весь маршрут:  #{@train.route.full_route}"
  end

  def train_selector
    @train_list.each.with_index(1) { |train, index| puts "#{index} - #{train.number}" }
    train_in_list = gets.chomp.to_i
    @train = @train_list[train_in_list - 1]
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def create_train
    puts 'Введите номер поезда (3 буквы/цифры в любом порядке, необязательный дефис и еще 2 буквы/цифры): '
    number = gets.chomp
    puts "Выберите тип поезда: 1 'Грузовой' 2 'Пассажирский'"
    @kind = gets.chomp
    @train = if @kind == 1
               CargoTrain.new(number)
             else
               PassengerTrain.new(number)
             end
    @train_list.push(@train)
    puts "Вы создали #{@train.kind} поезд: #{@train.number} "
    @train_list.each.with_index(1) { |train, index| puts "#{train.number} - #{index}" }
    p "Всего поездов: #{@train_list.count}"
  rescue ArgumentError => e
    p "Ошибка c:  #{e.message}"
    p 'Вы ввели не верный формат номера! Попробуйте еще раз.'
    retry
  end

  def adjust_route
    puts 'Выберите маршрут для редактирования из списка: '
    @route_list.each.with_index(1) { |route, index| puts " #{index} -- #{route.full_route}" }
    route_number = gets.chomp.to_i
    @route = @route_list[route_number - 1]
    puts "Управление маршрутом:
       1 'Добавить станцию в маршрут'
       2 'Удалить станцию из маршрута' "
    adjust = gets.chomp.to_i
    adjust == 1 ? route_add_station(@route) : route_delete_station(@route)
  end

  def route_add_station(route)
    puts 'Выберите станцию, которую нужно добавить к маршруту: '
    @station_list.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    station_in_list = gets.chomp.to_i
    station = @station_list[station_in_list - 1]
    route.route_station_add(station)
    puts "Вы добавили #{station.name} к маршруту.  #{route.full_route}"
    @route_list.each.with_index(1) { |_route, index| puts " #{index} -- #{route.full_route}" }
  end

  def route_delete_station(route)
    p route.full_route.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    puts 'Выберите станцию, которую нужно удалить из маршрута: '
    station_in_route = gets.chomp.to_i
    station = route.full_route[station_in_route - 1]
    route.route_station_remove(station)
    puts "Вы удалили #{station.name} из маршрута.  #{route.full_route}"
    @route_list.each.with_index(1) { |_route, index| puts " #{index} -- #{route.full_route}" }
  end

  def create_route
    @station_list.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
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
  rescue StandardError => e
    p "Ошибка c:  #{e.message}"
    p 'Станции должны быть разными! Попробуйте еще раз.'
    retry
  end

  def train_add_route
    puts 'Выберите поезд, которому нужно добавить маршрут: '
    train_selector
    puts 'Выберите маршрут для поезда из списка: '
    @route_list.each.with_index(1) { |route, index| puts " #{index} -- #{route.full_route}" }
    route_number = gets.chomp.to_i
    route = @route_list[route_number - 1]
    @train.add_route(route)
    p "Поезд #{@train.number} принял маршрут  #{@train.route}"
  end

  def tack_carriage
    puts 'Выберите поезд, к которому нужно добавить вагон: '
    train_selector
    @train.stop
    p 'Укажите номер вагона (русскими буквами с заглавной): '
    carriage_name = gets.chomp
    p 'Укажите  количество мест или общий объем вагона: '
    new_carriage_pull = gets.chomp.to_i
    new_carriage = if @train.kind == 'Грузовой'
                     CargoCarriage.new(carriage_name, new_carriage_pull)
                   else
                     PassengerCarriage.new(carriage_name, new_carriage_pull)
                   end
    @train.carriages_add(new_carriage)
    p "Добавлен вагон #{new_carriage.name} к поезду  #{@train.number} всего: #{@train.carriages_count}"
    p "Список: #{@train.carriages_pull.each.with_index(1) do |carriage, index|
    puts "#{index} - #{carriage.name} : #{carriage.kind} вместимость #{carriage.pull}"
  end
               }"
  end

  def unhook_carriage
    puts 'Выберите поезд, у которого нужно отцепить вагон: '
    train_selector
    @train.stop
    @train.carriages_pull.each.with_index(1) { |carriage, index| puts "#{index} - #{carriage.name}" }
    puts 'Выберите вагон: '
    carriage_num = gets.chomp.to_i
    carriage = @train.carriages_pull[carriage_num - 1]
    @train.carriages_remove(carriage)
    p "Вы удалили вагон от поезда  #{@train.number}"
    p 'Всего вагонов: ' "#{@train.carriages_count}" ' список ' "#{@train.carriages_pull}"
  end

  def engage_carriage
    puts 'Выберите поезд, в вагоне которого нужно занять место: '
    train_selector
    puts 'Выберите вагон, место в который нужно занять: '
    @train.carriages_pull.each.with_index(1) { |carriage, index| puts "#{index} - #{carriage.name}" }
    carriage_number = gets.chomp.to_i
    carriage = @train.carriages_pull[carriage_number - 1]
    if @train.kind == 'Грузовой'
      carriage.engage_volume
      puts "Занятого объема в вагоне: #{carriage.taken_volume}"
      puts "Оставшийся свободный обьем в вагоне: #{carriage.volume}"
    else
      carriage.engage_place
      puts "Занятых мест в вагоне: #{carriage.taken_place} "
      puts "Оставшихся свободных мест в вагоне: #{carriage.places} "
    end
  end

  def station_explorer
    p 'Полный список станций: '
    @station_list.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    puts 'Выберите станцию, которую нужно просмотреть: '
    station_in_list = gets.chomp.to_i
    station = @station_list[station_in_list - 1]
    puts "Вы выбрали станцию: #{station.name}"
    p "Список поездов на станции: #{station.station_pull_kind}"
    p "Всего поездов на станции: #{station.station_pull.count}"
    station.each_train do |train, index|
      p "#{index + 1} - #{train.kind} поезд #{train.number} вагонв: #{train.carriages_pull.count}"
    end
  end

  def train_explorer
    puts 'Выберите поезд, который нужно просмотреть: '
    train_selector
    puts "Вы выбрали #{@train.kind.downcase} : #{@train.number}"
    p 'Список вагонов поезда: '
    @train.carriages_pull.each.with_index(1) { |carriage, index| puts "#{index} - #{carriage.name}" }
    p "Всего вагонов у поезда: #{@train.carriages_pull.count}"
    @train.each_carriage do |carriage, index|
      if carriage.kind == 'Грузовой'
        puts "#{index + 1} -  #{carriage.kind} вагон #{carriage.name} вместимостью: #{carriage.pull}
        (занятый объем: #{carriage.taken_volume}/ свободные объем: #{carriage.volume})"
      else
        puts "#{index + 1} -  #{carriage.kind} вагон #{carriage.name} вместимостью: #{carriage.pull}
        (занятых мест: #{carriage.taken_place}/ свободных мест: #{carriage.places})"
      end
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end
# rubocop: enable Metrics/ClassLength
ui = Main.new
ui.menu
