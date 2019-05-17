require 'garage'

describe 'garage' do

  let (:garage) { Garage.new }
  let (:bike) { double(:bike, :working? => false) }
  let (:halfords_bike) { double(:bike, :working? => false) }

  context 'listing contents' do
    it 'returns empty array when empty' do
      expect(garage.bikes).to eq([])
    end      
  end

  context 'receiving bikes' do
    it 'contains added bikes' do
      garage.receive(bike)
      expect(garage.bikes).to include(bike)
    end
  end


end