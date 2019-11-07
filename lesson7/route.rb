require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :station, :full_route

  def initialize(first_station, end_station)
    @full_route = [first_station, end_station]
    valid?
    register_instance
  end

  def route_station_add(station)
    @full_route.insert(-2, station)
  end

  def route_station_remove(station)
    return unless @full_route.include?(station)

    @full_route.delete(station)
  end

  def valid?
    validate!
    true
  end

  private

  def validate!
    raise StandardError if @full_route.first == @full_route.last
  end
end
