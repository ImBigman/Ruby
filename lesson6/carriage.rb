require_relative 'company_name'

class Carriage
  include CompanyName
  attr_reader :name, :kind
  NAME_FORMAT = /^[А-Я]{1}+.*/.freeze

  def validate!
    kinds = %w[Грузовой Пассажирский]

    raise ArgumentError if name !~ NAME_FORMAT
    raise ArgumentError if kinds.include?(kind) == false
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
