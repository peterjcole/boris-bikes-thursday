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
    expect { subject.release_bike }.to raise_error(RuntimeError)
  end

  it "should allow second bike to be docked" do
    subject.dock(bike)

    expect { subject.dock(pedalo) }.not_to raise_error
  end

  it "should have capacity to dock 20 bikes" do
    expect { 20.times { subject.dock(Bike.new) } }.not_to raise_error
  end

  it "should raise error if more than 20 bikes" do
    expect { 21.times { subject.dock(Bike.new) } }.to raise_error(RuntimeError)
  end

  it "should raise error if no bikes available after bikes have been docked and then released" do
    2.times { subject.dock(Bike.new) }
    expect { 3.times { subject.release_bike } }.to raise_error(RuntimeError)
  end
end
