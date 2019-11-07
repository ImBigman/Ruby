require_relative '../lesson7/carriage'

class PassengerCarriage < Carriage
  attr_reader :places, :taken_place

  def initialize(name, kind = 'Пассажирский', pull)
    super
    @taken_place = 0
    @places = pull
  end

  def engage_place
    return unless @places.positive?

    @taken_place += 1
    @places -= 1
  end
end
