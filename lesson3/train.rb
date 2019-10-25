# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train < Route
  attr_accessor :current_speed, :carriages, :kind, :number, :route, :current_station
  def initialize(number, kind, carriages)
    @number = number
    @kind = kind
    @carriages = carriages
    @current_speed = 0
    @current_station
    @route
  end

  def carriages_add
    if @current_speed.zero?
      @carriages += 1
      puts "К #{@number.downcase} присоединился вагон, теперь у него их #{@carriages}."
    elsif puts 'На скорости нельзя присоединять вагоны.'
    end
  end

  def carriages_remove
    if @current_speed.zero? && @carriages.positive?
      @carriages -= 1
      puts "От #{@number.downcase} отсоединили вагон, теперь у него их #{@carriages}."
    elsif puts 'На скорости нельзя отсоединять вагоны или вагонов больше не осталось.'
    end
  end

  def faster(speed)
    @current_speed += speed
    puts "#{@kind} #{@number.downcase} разогнался до #{@current_speed}"
  end

  def stop
    @current_speed = 0
    puts "#{@kind} #{@number.downcase} остановился"
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    puts "Добавлен путевой лист:  #{route.stations}"
  end

  def inspect_route
    if @current_station != @route.stations.last
      next_station = @route.stations[@route.stations.index(@current_station) + 1]
      puts 'Текущая станция: ' + @current_station
      puts 'Следующая станция в пути: ' + next_station
    end
    if @current_station == @route.stations.first
      puts 'Предыдущей станции нет'
    elsif  previous_station = @route.stations[@route.stations.index(@current_station) - 1]
      puts 'Предыдущая станция: ' + previous_station
    end
  end

  def back_on_route
    return unless @current_station != @route.stations.first

    @current_station = @route.stations[@route.stations.index(@current_station) - 1]
  end

  def forward_on_route
    return unless @current_station <= @route.stations.last

    @current_station = @route.stations[@route.stations.index(@current_station) + 1]
  end
end
