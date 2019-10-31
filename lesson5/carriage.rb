require_relative 'company_name'

class Carriage
  include CompanyName
  attr_reader :name, :kind

  @@instances = 0

  def initialize(name, kind)
    @name = name
    @kind = kind
    @@instances += 1
    company_name
  end
end
