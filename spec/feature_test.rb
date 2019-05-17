require './lib/docking_station.rb'

station = DockingStation.new(15)
# should be initialized
# 15.times { station.dock(Bike.new) }
# # Should work fine
# station.dock(Bike.new)
# # Should fail with error
station.dock(Bike.new)
station.dock(Bike.new, true)
# => Thanks, we have reported this bike as broken

first_bike = station.release_bike
# => Bike returned
second_bike = station.release_bike
# => Error
# .times { station.release_bike }