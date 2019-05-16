require_relative "bike.rb"

class DockingStation
  attr_reader :docked
  def initialize
    @docked = []
  end

  def release_bike
    return @docked.empty? ? raise { RuntimeError.new } : @docked.shift
  end

  def dock(bike)
    @docked.length < 20 ? @docked.push(bike) : raise { RuntimeError.new }
  end
end
