require 'docking_station.rb'

describe DockingStation do
  # it 'responds to release_bike' do
  #   expect(DockingStation).to respond_to :release_bike
  # end
  it { should respond_to :release_bike }

  it 'should return a working bike' do
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it { should respond_to(:dock).with(1).argument }

  it { should respond_to :docked }

  it 'should store a bike that\'s been docked' do
    my_dock = DockingStation.new
    pedalo = Bike.new
    my_dock.dock(pedalo)

    expect(my_dock.docked).to eq(pedalo)
  end

end
