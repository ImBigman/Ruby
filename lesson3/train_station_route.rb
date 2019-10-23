require './_route'
require './_train'
require './_station'

r = Route.new('Станция №1', 'Станция №5')
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
a = Train.new('Поезд №12', 'Пассажирский', 0)
puts 'Прибыл ' + a.kind + ' - ' + a.number
puts ' '
p 'Местонахождение поезда: ' + a.current_station
puts ' '
puts a.faster(60)
puts a.stop
puts a.carriages_add
puts a.carriages_remove
puts a.route_add(r)
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
b = Train.new('Поезд №10', 'Пассажирский', 2)
puts 'Прибыл ' + b.kind + ' - ' + b.number
puts ' '
p 'Местонахождение поезда: ' + b.current_station
puts ' '
s.receive_train(b)
p s.station_pull
puts ' '
s.station_pull_kind
puts ' '
s.send_train(b)
s.on_station
puts ' '
a.forward_on_route
p a

