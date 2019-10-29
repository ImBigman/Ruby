class Test
def initialize(number)
  @test_number = number
  @test_name = []
end
end
a = []

b = Test.new('asd')
c = Test.new('asdww')
a << b
a << c
hash = Hash.new
a.each_with_index { |index, item|
  hash[index] = item
}

p hash
