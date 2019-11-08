require_relative '../lesson8/carriage'

class CargoCarriage < Carriage
  attr_reader :volume, :taken_volume
  # rubocop: disable Style/OptionalArguments
  def initialize(name, kind = 'Грузовой', pull)
    super
    @taken_volume = 0
    @pull = pull
    @volume = 0
  end
  # rubocop: enable Style/OptionalArguments

  def engage_volume
    return unless @taken_volume != @pull

    @taken_volume += 1
    @volume = @pull - @taken_volume
  end
end
