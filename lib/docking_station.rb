require_relative "bike.rb"

class DockingStation
  attr_reader :docked

  def release_bike
    return @docked ? @docked : raise { RuntimeError.new }
  end

  def dock(bike)
    @docked == nil ? @docked = bike : raise { RuntimeError.new }
  end
end
