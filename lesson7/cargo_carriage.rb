require_relative '../lesson7/carriage'

class CargoCarriage < Carriage
  attr_reader :volume, :taken_volume

  def initialize(name, kind = 'Грузовой', pull)
    super
    @taken_volume = 0
    @volume = pull
  end

  def engage_volume
    return unless @volume.positive?

    @taken_volume += 1
    @volume -= 1
  end
end