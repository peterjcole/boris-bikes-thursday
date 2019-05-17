require "docking_station.rb"

describe DockingStation do
  # it 'responds to release_bike' do
  #   expect(DockingStation).to respond_to :release_bike
  # end
  let(:bike) { Bike.new }
  let(:pedalo) { Bike.new }

  it { should respond_to :release_bike }

  it "should return a working bike" do
    subject.dock(bike)
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it { should respond_to(:dock).with(1).argument }

  it { should respond_to :docked }

  it 'should store a bike that\'s been docked' do
    subject.dock(pedalo)

    expect(subject.docked).to include(pedalo)
  end

  it "should not return a bike if there are none available" do
    expect { subject.release_bike }.to raise_error(RuntimeError, "No bikes available")
  end

  it "should allow second bike to be docked" do
    subject.dock(bike)

    expect { subject.dock(pedalo) }.not_to raise_error
  end

  it "should have capacity to dock 20 bikes" do
    expect { DockingStation::DEFAULT_CAPACITY.times { subject.dock(Bike.new) } }.not_to raise_error
  end

  it "should raise error if more than 20 bikes" do
    expect { (DockingStation::DEFAULT_CAPACITY + 1).times { subject.dock(Bike.new) } }.to raise_error(RuntimeError, "Station over capacity")
  end

  it "should raise error if no bikes available after bikes have been docked and then released" do
    2.times { subject.dock(Bike.new) }
    expect { 3.times { subject.release_bike } }.to raise_error(RuntimeError, "No bikes available")
  end

  context 'initialising with capacity provided as argument' do
    it 'should be able to be instantiated when providing a capacity' do
      expect(DockingStation.new(15)).to be_a(DockingStation)
    end
    it 'should have the capacity which was provided when initializing' do
      station = DockingStation.new(30)
      30.times { station.dock(Bike.new) }
      expect { station.dock(Bike.new) }.to raise_error(RuntimeError, "Station over capacity")

    end
  end

  context 'returning broken bikes' do
    it 'should not release a bike if there are only broken bikes docked' do
      subject.dock(Bike.new)
      subject.dock(Bike.new, true)

      subject.release_bike

      expect { subject.release_bike }.to raise_error(RuntimeError, "No bikes available")
    end

    it 'should release working bikes only' do
      subject.dock(Bike.new, false)
      subject.dock(Bike.new, true)
      subject.dock(Bike.new, false)
      released_bikes = []
      2.times { released_bikes.push(subject.release_bike) }
      expect(released_bikes.all? { |bike| bike.working? } ).to be true
    end
  end
end
