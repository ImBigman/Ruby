require_relative '../lesson7/carriage'

class PassengerCarriage < Carriage
  attr_reader :places, :taken_place

  def initialize(name, kind = 'Пассажирский', pull)
    super
    @taken_place = 0
    @places = 0
    @pull = pull
  end

  def engage_place
    return unless @taken_place != @pull

    @taken_place += 1
    @places = @pull - @taken_place
  end
end
