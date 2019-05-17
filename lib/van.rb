class Van
  attr_reader :bikes
  def initialize
    @bikes = []
  end

  def take_from(station)
    @bikes += station.release_broken
  end

  def deliver_to(garage)
    @bikes.each { |bike| garage.receive(bike) }
    @bikes = []
    return "Delivered successfully"
  end

end