class Station < Route
  attr_reader :station_pull, :name
  def initialize(name)
    @name = name
    @station_pull = []
  end

  def send_train(train)
    if @station_pull.include?(train)
      @station_pull.delete(train)
      puts "#{train.number} отправлен со : #{@name}"
    elsif puts "Поезда с номером #{train.number} нет на : #{@name}"
    end
  end

  def receive_train(train)
    @station_pull << train
    train.current_station = @name
    puts "#{@name} приняла #{train.number} "
  end

  def station_pull_kind
    a = 'Грузовой'
    b = 'Пассажирский'
    c = @station_pull.count { |train|  train.kind == 'Грузовой' }
    d = @station_pull.count { |train|  train.kind == 'Пассажирский' }
    puts 'Колисетво поездов типа: ' "#{a}" + ' - ' + c.to_s
    puts 'Колисетво поездов типа: ' "#{b}" + ' - ' + d.to_s
  end

  def on_station
    puts 'Количество поездов на станции: ' "#{@station_pull.count}"
  end
end
