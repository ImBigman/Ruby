require_relative '../lesson8/carriage'

class CargoCarriage < Carriage
  attr_reader :volume, :taken_volume

  def initialize(name,pull , kind = 'Грузовой')
    super
    @taken_volume = 0
    @pull = pull
    @volume = 0
  end

  def engage_volume
    return unless @taken_volume != @pull

    @taken_volume += 1
    @volume = @pull - @taken_volume
  end
end
