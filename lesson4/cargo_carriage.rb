require_relative '../lesson4/carriage'
class CargoCarriage < Carriage
  attr_reader :name, :kind

  def initialize(name, kind = 'Грузовой')
    super
  end
end