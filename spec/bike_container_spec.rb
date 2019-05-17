require 'bike_container'

class BikeContainerTest
  include BikeContainer
end

describe 'bike_container' do

  let(:bike_container) { BikeContainerTest.new }

  it 'should respond to :bikes' do
    expect(bike_container).to respond_to(:bikes)
  end

  it 'should default to an empty array' do
    expect(bike_container.bikes).to eq([])

  end
end