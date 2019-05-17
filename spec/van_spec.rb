require 'van'

describe 'van' do

  let(:van) { Van.new }
  let(:bike) { double(:bike, :working? => false) }
  let(:station) { double(:station, :release_broken => [bike]) }
  let(:garage) { double(:garage, :receive => :bike) }

  context 'listing contents' do
    it 'returns empty array when empty' do
      expect(van.bikes).to eq([])
    end
  end

  context 'picking up bikes from a station' do
    it 'picks up a single bike' do
      van.take_from(station)
      expect(van.bikes).to include(bike)
    end
  end

  context 'delivering bikes' do
    it "returns all bikes" 
    it "doesn't contain bikes after delivering" do
      van.take_from(station)
      van.deliver_to(garage)
      expect(van.bikes).to be_empty
    end

  end
end