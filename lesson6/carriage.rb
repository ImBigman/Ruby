require_relative 'company_name'
require_relative 'validate'

class Carriage
  include CompanyName
  include Validator

  attr_reader :name, :kind

  def initialize(name, kind)
    @name = name
    @kind = kind
    validate_kind
  end
end
