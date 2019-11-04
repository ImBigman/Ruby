require_relative 'company_name'

class Carriage
  include CompanyName
  attr_reader :name, :kind
  NAME_FORMAT = /^[А-Я]{1}+.*/.freeze

  def validate!
    raise ArgumentError if name !~ NAME_FORMAT
    raise ArgumentError unless Train::TYPES.include?(kind)
  end

  def initialize(name, kind)
    @name = name.to_s
    @kind = kind.to_s
    validate!
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
