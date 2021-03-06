require_relative 'instance_counter'

class Station
  include InstanceCounter

  NAME_FORMAT = /^[А-Я]+.*/.freeze

  attr_reader :station_pull, :name, :block

  def validate!
    raise ArgumentError if name.length < 3
    raise ArgumentError if name !~ NAME_FORMAT
  end

  def initialize(name)
    @name = name
    @station_pull = []
    validate!
    register_instance
  end

  def send_train(train)
    return unless @station_pull.include?(train)

    @station_pull.delete(train)
  end

  def receive_train(train)
    @station_pull << train
  end

  def each_train(&_block)
    if block_given?
      @station_pull.each_with_index { |train, index| yield(train, index) }
    else false
    end
  end

  def station_pull_kind
    station_pull_kind = []
    @station_pull.each { |train, _| station_pull_kind << { train.kind => train.number } }
    station_pull_kind.inject { |memo, el| memo.merge(el) { |_, old_v, new_v| [old_v + ', ' + new_v] } }
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
