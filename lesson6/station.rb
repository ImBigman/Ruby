# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
require_relative 'instance_counter'

class Station
  include InstanceCounter

  NAME_FORMAT = /^[А-Я]{1}+.*/.freeze

  attr_reader :station_pull, :name

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def validate_name
    raise ArgumentError if name.nil?
    raise ArgumentError if name.length < 3
    raise ArgumentError if name !~ NAME_FORMAT
  end

  def initialize(name)
    @name = name
    @station_pull = []
    @@all_stations << self
    register_instance
    validate_name
  end

  def send_train(train)
    return unless @station_pull.include?(train)

    @station_pull.delete(train)
  end

  def receive_train(train)
    @station_pull << train
  end

  def station_pull_kind
    station_pull_kind = []
    @station_pull.each do |train, _|
      station_pull_kind << { train.kind => train.number }
    end
    station_pull_kind.inject { |memo, el| memo.merge(el) { |_, old_v, new_v| [old_v + ', ' + new_v] } }
  end

  def valid?
    validate_name
    true
  rescue StandardError
    false
  end
end
