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
    puts "#{@name} приняла #{train.number} "
  end

  def station_pull_kind
    a = 'Грузовой'
    b = 'Пассажирский'
    c = @station_pull.count { |train|  train.kind == a }
    d = @station_pull.count { |train|  train.kind == b }
    puts 'Колисетво поездов типа: ' "#{a}" + ' - ' + c.to_s
    puts 'Колисетво поездов типа: ' "#{b}" + ' - ' + d.to_s
  end

  def on_station
    @station_pull.each { |train| puts 'На станции: ' "#{train.number}" }
    puts 'Количество поездов на станции всего: ' "#{@station_pull.count}"
  end
end
