require_relative 'accessors'
require_relative 'validation'

class Test1
  include Accessors

  attr_accessor_with_history :a, :b, :c, :d
  strong_attr_accessor :d, 'Integer'
end

class Test2
  include Validation
  attr_reader :name, :attr_hash

  validate :name, :presence
  validate :name, :format, /A-Z/
  validate :name, :type, String

  def initialize(name, number)
    @name = name
    @number = number
    validate!
  end
end



test2 = Test2.new('Name', 'qwe_12')
p test2
p test2.validate?

test1 = Test1.new
p test1.a = 4
p test1.a = 5
p test1.a = 6
p test1.a = 7
p test1.a
p test1.a_history

