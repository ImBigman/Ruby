require_relative '../lesson7/carriage'

class PassengerCarriage < Carriage
  attr_reader :places, :taken_place

  def initialize(name, kind = 'Пассажирский', pull)
    super
    @taken_place = 0
    @all_places = []
    @places = @all_places.concat(Array.new(pull, 'free_place'))
  end

  def engage_place
    return unless @places.include?('free_place')

    @taken_place += 1
    @places << 'taken_place'
    @places.delete_at(0)
  end

  def free_places
    @all_places.count('free_place')
  end
end
