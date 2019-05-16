require_relative "bike.rb"

class DockingStation
  attr_reader :docked
  def initialize
    @docked = []
  end

  def release_bike
    return @docked.empty? ? raise { RuntimeError.new } : @docked[0]
  end

  def dock(bike)
    @docked.length < 21 ? @docked.push(bike) : raise { RuntimeError.new }
  end
end
