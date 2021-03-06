require_relative 'company_name'
require_relative '../lesson8/train'

class Carriage
  include CompanyName
  attr_reader :name, :kind, :pull

  NAME_FORMAT = /^[А-Я]+.*/.freeze

  def validate!
    raise ArgumentError if name !~ NAME_FORMAT
    raise ArgumentError unless Train::TYPES.include?(kind)
  end

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
