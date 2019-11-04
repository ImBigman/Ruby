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
# ---
# Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. (пока все методы публичны)
require_relative 'instance_counter'
require_relative 'company_name'


class Train
  include CompanyName
  include InstanceCounter

  KIND_FORMAT = /^[Г, П]{1}+.+[й]{1}$/.freeze
  NUMBER_FORMAT = /^\w{3}[_]*{1}\w{2}$/.freeze
  TYPES = %w[Грузовой Пассажирский].freeze

  attr_reader :current_speed, :kind, :number, :route, :current_station, :carriages_pull

  @@all_trains = {}

  def self.find(number)
    @@all_trains[number]
  end

  def validate!
    raise ArgumentError if number !~ NUMBER_FORMAT
    raise ArgumentError if kind !~ KIND_FORMAT
  end

  def initialize(number, kind)
    @number = number
    @kind = kind
    @carriages_pull = []
    @current_speed = 0
    validate!
    register_instance
    @@all_trains[number] = self
  end

  def carriages_add(carriage)
    return unless @current_speed.zero?

    return unless carriage.kind == @kind

    @carriages_pull << carriage
  end

  def carriages_count
    @carriages_pull.count
  end

  def carriages_remove(carriage)
    return unless @current_speed.zero?

    @carriages_pull.delete(carriage)
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
    elsif previous_station == @route.full_route[@route.full_route.index(@current_station) - 1]
      previous_station
    end
  end

  def back_on_route
    return unless @current_station != @route.full_route.first

    @current_station.send_train(self)
    @current_station = @route.full_route[@route.full_route.index(@current_station) - 1]
    @current_station.receive_train(self)
  end

  def forward_on_route
    return unless @current_station != @route.full_route.last

    @current_station.send_train(self)
    @current_station = @route.full_route[@route.full_route.index(@current_station) + 1]
    @current_station.receive_train(self)
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end

