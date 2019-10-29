require_relative '../lesson4/carriage'
class PassengerCarriage < Carriage
  attr_reader :name, :kind

  def initialize(name, kind = 'Пассажирский')
    super
  end
end