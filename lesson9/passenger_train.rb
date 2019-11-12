require_relative '../lesson9/train'
require_relative 'validation'

class PassengerTrain < Train
  def initialize(number, kind = 'Пассажирский')
    super
  end
end
