require_relative '../lesson4/train'
class CargoTrain < Train
  attr_reader :current_speed, :kind, :number, :route, :current_station, :carriages_pull

  def initialize(number, kind = 'Грузовой')
    super
  end
end