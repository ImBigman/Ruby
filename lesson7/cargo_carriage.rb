require_relative '../lesson7/carriage'

class CargoCarriage < Carriage
  attr_reader :volume, :taken_volume

  def initialize(name, kind = 'Грузовой', pull)
    super
    @taken_volume = 0
    @all_volume = []
    @volume = @all_volume.concat(Array.new(pull, 'free_volume'))
  end

  def engage_volume
    return unless @volume.include?('free_volume')

    @taken_volume += 1
    @volume << 'taken_volume'
    @volume.delete_at(0)
    @volume
  end

  def free_volume
    @all_volume.count('free_volume')
  end
end