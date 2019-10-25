# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station < Route
  attr_reader :station_pull, :name
  def initialize(name)
    @name = name
    @station_pull = []
  end

  def send_train(train)
    if @station_pull.include?(train)
      @station_pull.delete(train)
    elsif puts "Поезда с номером #{train.number} нет на : #{@name}"
    end
  end

  def receive_train(train)
    @station_pull << train
  end

  def station_pull_kind
    station_pull_kind = []
    @station_pull.each do |train, k|
      station_pull_kind << { train.kind => train.number }
    end
    p station_pull_kind.inject{ |memo, el| memo.merge( el ) { |k, old_v, new_v| [old_v + ', ' + new_v] } }
    p 'Всего: ' + station_pull.count.to_s
  end
end
