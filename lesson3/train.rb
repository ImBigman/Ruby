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
class Train
  attr_reader :current_speed, :carriages, :kind, :number, :route, :current_station

  def initialize(number, kind, carriages)
    @number = number
    @kind = kind
    @carriages = carriages
    @current_speed = 0
  end

  def carriages_add
    return unless @current_speed.zero?

    @carriages += 1
  end

  def carriages_remove
    return unless @current_speed.zero? && @carriages.positive?

    @carriages -= 1
  end

  def faster(speed)
    @current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = @route.full_route.first
  end

  def next_station
    return unless @current_station != @route.full_route.last

    next_station = @route.full_route[@route.full_route.index(@current_station) + 1]
    next_station
  end

  def previous_station
    if @current_station == @route.full_route.first
    elsif previous_station = @route.full_route[@route.full_route.index(@current_station) - 1]
      previous_station
    end
  end

  def back_on_route
    return unless @current_station != @route.full_route.first

    @current_station = @route.full_route[@route.full_route.index(@current_station) - 1]
  end

  def forward_on_route
    return unless @current_station <= @route.full_route.last

    @current_station = @route.full_route[@route.full_route.index(@current_station) + 1]
  end
end

