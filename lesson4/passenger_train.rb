require_relative '../lesson4/train'
class PassengerTrain < Train
  attr_reader :current_speed, :number, :route, :current_station, :carriages_pull, :kind

  def initialize(number, kind = 'Пассажирский')
    super
  end
end
