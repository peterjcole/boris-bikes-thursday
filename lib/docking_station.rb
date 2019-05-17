require_relative "bike.rb"

class DockingStation
  attr_reader :docked
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @docked = []
    @capacity = capacity
  end

  def release_bike
    return @docked.empty? ? raise { RuntimeError.new } : @docked.shift
  end

  def dock(bike)
    full? ? raise { RuntimeError.new } : @docked.push(bike)
  end

  private

  def full?
    true if @docked.length == @capacity
  end
end
