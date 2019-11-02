require_relative '../lesson5/carriage'

class PassengerCarriage < Carriage
  def initialize(name, kind = 'Пассажирский')
    super
  end
end