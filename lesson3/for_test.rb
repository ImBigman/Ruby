require './route'
require './train'
require './station'

r = Route.new('Станция №1', 'Станция №6')
puts ' '
puts r.route_station_add('Станция №3')
r.full_route
puts ' '
puts r.route_station_remove('Станция №3')
r.full_route
puts ' '
puts r.route_station_add('Станция №2')
r.full_route
puts ' '
puts r.route_station_add('Станция №4')
r.full_route
puts ' '
a = Train.new('Поезд №12', 'Пассажирский', 0)
puts 'Прибыл ' + a.kind + ' - ' + a.number
puts ' '
p a.current_station
puts ' '
puts a.faster(60)
puts a.stop
puts a.carriages_add
puts a.carriages_remove
puts a.add_route(r)
p 'Местонахождение поезда: ' + a.current_station
puts ' '
s = Station.new('Cтанция №2')
p 'Открылась ' + s.name
puts ' '
s.receive_train(a)
p s.station_pull
puts ' '
u = Station.new('Cтанция №1')
p 'Открылась ' + u.name
puts ' '
u.receive_train(a)
p u.station_pull
puts ' '
b = Train.new('Поезд №10', 'Грузовой', 2)
puts 'Прибыл ' + b.kind + ' - ' + b.number
puts ' '
c = Train.new('Поезд №7', 'Пассажирский', 1)
s.receive_train(c)
puts ' '
s.receive_train(b)
puts ' '
s.station_pull
s.station_pull_kind
puts ' '
s.send_train(b)
puts ' '
p a
a.forward_on_route
a.next_station
