require_relative "bike.rb"

class DockingStation
  attr_reader :docked
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @docked = []
    @capacity = capacity
  end

  def release_bike
    if @docked.any? { |bike| bike.working? == true } && @docked.empty? == false
      bike = @docked.find { |bike| bike.working? == true }
      @docked.delete(bike)
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
      @docked.push(bike)
    end
  end

  def release_broken
    broken = @docked.select { |bike| bike.working? == false }
    @docked.delete_if { |bike| bike.working? == false }
    return broken
  end

  private

  def full?
    true if @docked.length == @capacity
  end
end
