require "docking_station.rb"

describe DockingStation do

  let(:bike) { double(:bike, :working? => true) }
  let(:pedalo) { double(:bike, :working? => true) }
  let(:halfords_bike) { double(:bike, :working? => false) }

  it { should respond_to :release_bike }

  it "should return a working bike" do
    allow(bike).to receive(:working?).and_return(true)
    subject.dock(bike)
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it { should respond_to(:dock).with(1).argument }

  it { should respond_to :bikes }

  it 'should store a bike that\'s been docked' do
    subject.dock(pedalo)

    expect(subject.bikes).to include(pedalo)
  end

  it "should not return a bike if there are none available" do
    expect { subject.release_bike }.to raise_error(RuntimeError, "No bikes available")
  end

  it "should allow second bike to be docked" do
    subject.dock(bike)

    expect { subject.dock(pedalo) }.not_to raise_error
  end

  it "should have capacity to dock 20 bikes" do
    expect { DockingStation::DEFAULT_CAPACITY.times { subject.dock(double(:bike)) } }.not_to raise_error
  end

  it "should raise error if more than 20 bikes" do
    expect { (DockingStation::DEFAULT_CAPACITY + 1).times { subject.dock(double(:bike)) } }.to raise_error(RuntimeError, "Station over capacity")
  end

  it "should raise error if no bikes available after bikes have been docked and then released" do
    2.times { subject.dock(double(:bike, :working? => true)) }
    
    expect { 3.times { subject.release_bike } }.to raise_error(RuntimeError, "No bikes available")
  end

  context 'initialising with capacity provided as argument' do
    it 'should be able to be instantiated when providing a capacity' do
      expect(DockingStation.new(15)).to be_a(DockingStation)
    end
    it 'should have the capacity which was provided when initializing' do
      station = DockingStation.new(30)
      30.times { station.dock(double(:bike)) }
      expect { station.dock(double(:bike)) }.to raise_error(RuntimeError, "Station over capacity")

    end
  end

  context 'when returning broken bikes' do
    it 'should not release a bike if there are only broken bikes docked' do
      subject.dock(double(:bike, :working? => true))
      subject.dock(double(:bike, :working? => false))

      subject.release_bike

      expect { subject.release_bike }.to raise_error(RuntimeError, "No bikes available")
    end

    it 'should release working bikes only' do
      subject.dock(bike)
      subject.dock(halfords_bike)
      subject.dock(pedalo)
      released_bikes = []
      2.times { released_bikes.push(subject.release_bike) }
      expect(released_bikes.all? { |bike| bike.working? } ).to be true
    end
  end

  context 'when releasing broken bikes' do
    it 'should release an array of all broken bikes' do
      subject.dock(halfords_bike)
      subject.dock(bike)
      subject.dock(pedalo)

      expect(subject.release_broken).to eq([halfords_bike])

    end

    it 'should not contain broken bikes after releasing' do
      subject.dock(halfords_bike)
      subject.dock(bike)
      subject.dock(pedalo)
      subject.release_broken
      expect(subject.bikes).to satisfy { |bikes| bikes.each { |bike| bike.working? } }

    end
  end
end
