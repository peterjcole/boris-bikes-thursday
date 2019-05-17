require_relative "bike.rb"

class DockingStation
  include BikeContainer
  attr_reader :bikes
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    if @bikes.any? { |bike| bike.working? == true } && @bikes.empty? == false
      bike = @bikes.find { |bike| bike.working? == true }
      @bikes.delete(bike)
      return bike
    else
      fail RuntimeError.new("No bikes available")
    end
  end

  def dock(bike, broken = false)
    bike.broken = true if broken == true
    if full?
      fail RuntimeError.new("Station over capacity")
    else
      @bikes.push(bike)
    end
  end

  def release_broken
    broken = @bikes.select { |bike| bike.working? == false }
    @bikes.delete_if { |bike| bike.working? == false }
    return broken
  end

  private

  def full?
    true if @bikes.length == @capacity
  end
end
