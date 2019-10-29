# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные
# могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :station, :first_station, :end_station, :route_station

  def initialize(first_station, end_station)
    @first_station = first_station
    @end_station = end_station
    @mid_stations = []
  end

  def route_station_add(station)
    @mid_stations << station
  end

  def route_station_remove(station)
    return unless @mid_stations.include?(station)

    @mid_stations.delete(station)
  end

  def full_route
    [@first_station] + @mid_stations + [@end_station]
  end
end
