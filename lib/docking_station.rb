require_relative "bike.rb"

class DockingStation
  DEFAULT_CAPACITY = 20
  attr_reader :docked

  def initialize
    @docked = []
  end

  def release_bike
    return @docked.empty? ? raise { RuntimeError.new } : @docked.shift
  end

  def dock(bike)
    full? ? raise { RuntimeError.new } : @docked.push(bike)
  end

  private

  def full?
    true if @docked.length == DEFAULT_CAPACITY
  end
end
