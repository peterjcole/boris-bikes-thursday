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
end
