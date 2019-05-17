class Bike
  attr_accessor :broken

  def initialize
    @broken = false
  end

  def working?
    !@broken
  end
end