require_relative '../lesson4/carriage'

class PassengerCarriage < Carriage
  def initialize(name, kind = 'Пассажирский')
    super
  end
end