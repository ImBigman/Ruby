class Route
  attr_accessor :route_station, :first_station, :end_station
  attr_reader :route
  def initialize(first_station, end_station)
    @first_station = first_station
    @end_station = end_station
    @route_station = []
    @route = [@first_station] + @route_station + [@end_station]
  end

  def route_station_add(station)
    if @route_station.include?(station) || @route.include?(station)
      puts 'Данная станция уже есть в маршруте.'
    elsif @route_station << station
      puts 'К пути добавлена промежуточная пункт: ' "#{station}."
    end
  end

  def route_station_remove(station)
    if @route_station.include?(station)
      @route_station.delete(station)
      puts "Из маршрута удалена:  #{station}."
    else
      puts 'В маршруте не было такой станции.'
    end
  end

  def full_route
    @route = [@first_station] + @route_station + [@end_station]
    p @route
  end
end
