require_relative 'company_name'

class Carriage
  include CompanyName

  KIND_FORMAT = /^[Г, П]{1}+.+[й]{1}$/.freeze
  NAME_FORMAT = /^[А-Я]{1}+.*/.freeze

  attr_reader :name, :kind

  def validate!
    raise ArgumentError if name.nil?
    raise ArgumentError if name !~ NAME_FORMAT
    raise ArgumentError if kind.nil?
    raise ArgumentError if kind !~ KIND_FORMAT
  end

  def initialize(name, kind)
    @name = name
    @kind = kind
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
