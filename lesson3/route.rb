# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные
# могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_accessor :route_station
  attr_reader :stations, :first_station, :end_station
  def initialize(first_station, end_station)
    @first_station = first_station
    @end_station = end_station
    @route_stations = []
    @stations = []
  end

  def route_station_add(station)
    if @route_stations.include?(station) || @stations.include?(station)
    else @route_stations << station
    end
  end

  def route_station_remove(station)
    return unless @route_stations.include?(station)

    @route_stations.delete(station)
  end

  def full_route
    @stations= [@first_station] + @route_stations + [@end_station]
    p @stations
  end
end
