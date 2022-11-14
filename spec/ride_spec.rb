require 'rspec'
require './lib/visitor'
require './lib/ride'

describe Ride do
  describe '#initialize' do
    it 'instantiates correctly' do
      ride = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      expect(ride).to be_a Ride
      expect(ride.name).to eq('Carousel')
      expect(ride.min_height).to eq(24)
      expect(ride.admission_fee).to eq(1)
      expect(ride.excitement).to eq(:gentle)
      expect(ride.total_revenue).to eq(0)
      expect(ride.rider_log).to eq({})
    end
  end
end
