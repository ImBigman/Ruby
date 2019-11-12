require_relative 'company_name'
require_relative 'train'
require_relative 'validation'

class Carriage
  include CompanyName
  include Validation

  attr_reader :name, :kind, :pull

  validate :name, :format, /^[А-Я]+.*/

  def initialize(name, pull, kind)
    @name = name.to_s
    @kind = kind.to_s
    validate!
    @pull = pull
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
