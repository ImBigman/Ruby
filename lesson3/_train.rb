class Train < Route
  attr_accessor :current_speed, :carriages, :kind, :number, :route, :current_station
  def initialize(number, kind, carriages)
    @number = number
    @kind = kind
    @carriages = carriages.to_i
    @current_speed = 0
    @current_station = 'находится в депо'
    @route = []
  end

  def carriages_add
    if @current_speed.zero?
      self.carriages += 1
      puts "К #{@number.downcase} присоединился вагон, теперь у него их #{@carriages}."
    elsif puts 'На скорости нельзя присоединять вагоны.'
    end
  end

  def carriages_remove
    if @current_speed.zero? && @carriages.positive?
      self.carriages -= 1
      puts "От #{@number.downcase} отсоединили вагон, теперь у него их #{@carriages}."
    elsif puts 'На скорости нельзя отсоединять вагоны или вагонов больше не осталось.'
    end
  end

  def faster(speed)
    self.current_speed += speed
    puts "#{@kind} #{@number.downcase} разогнался до #{@current_speed}"
  end

  def stop
    self.current_speed = 0
    puts "#{@kind} #{@number.downcase} остановился"
  end

  def add_route(route)
    @route = route
    self.current_station = @route.route.first
    puts "Добавлен путевой лист:  #{route.route}"
  end

  def inspect_route
    if @current_station != @route.route.last
      next_station = @route.route[@route.route.index(@current_station) + 1]
      puts 'Текущая станция: ' + @current_station
      puts 'Следующая станция в пути: ' + next_station
    end
    if @current_station == @route.route.first
      puts 'Предыдущей станции нет'
    elsif  previous_station = @route.route[@route.route.index(@current_station) - 1]
      puts 'Предыдущая станция: ' + previous_station
    end
  end

  def back_on_route
    return unless @current_station != @route.route.first

    @current_station = @route.route[@route.route.index(@current_station) - 1]
  end

  def forward_on_route
    return unless @current_station <= @route.route.last

    @current_station = @route.route[@route.route.index(@current_station) + 1]
  end
end
