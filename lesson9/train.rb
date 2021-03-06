require_relative 'instance_counter'
require_relative 'company_name'
require_relative 'validation'

class Train
  include CompanyName
  include InstanceCounter
  include Validation

  attr_reader :current_speed, :kind, :number, :route, :current_station, :carriages_pull, :attr_hash

  validate :number, :format, /^\w{3}[_]*\w{2}$/

  def initialize(number, kind)
    @number = number
    @kind = kind
    @carriages_pull = []
    @current_speed = 0
    validate!
    register_instance
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
    @current_station.receive_train(self)
  end

  def next_station
    return unless @current_station != @route.full_route.last

    @route.full_route[@route.full_route.index(@current_station) + 1]
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

  def each_carriage(&_block)
    if block_given?
      @carriages_pull.each_with_index { |carriage, index| yield(carriage, index) }
    else false
    end
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
