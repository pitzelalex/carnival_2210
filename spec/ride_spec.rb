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

  describe '#would_ride?' do
    it 'checks if a rider would board the ride' do
      ride = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:water)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:water)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:gentle)
      visitor4 = Visitor.new('Penny', 23, '$15')
      visitor4.add_preference(:gentle)

      expect(ride.would_ride?(visitor1)).to be true
      expect(ride.would_ride?(visitor2)).to be false
      expect(ride.would_ride?(visitor3)).to be true
      expect(ride.would_ride?(visitor4)).to be false
    end
  end

  describe '#board_rider' do
    it 'tracks that the rider rode the ride' do
      ride = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:water)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:water)

      ride.board_rider(visitor1)
      ride.board_rider(visitor2)

      expect(ride.rider_log).to eq({visitor1 => 1})
      expect(visitor1.spending_money).to eq(9)
      expect(visitor2.spending_money).to eq(5)
      expect(ride.total_revenue).to eq(1)

      ride.board_rider(visitor1)

      expect(ride.rider_log).to eq({visitor1 => 2})
      expect(visitor1.spending_money).to eq(8)
      expect(ride.total_revenue).to eq(2)
    end
  end

  describe '#log_rider' do
    it 'adds the rider to the @rider_log' do
      ride = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(ride.rider_log).to eq({})
      ride.log_rider(visitor1)
      expect(ride.rider_log).to eq({visitor1 => 1})
      ride.log_rider(visitor1)
      expect(ride.rider_log).to eq({visitor1 => 2})
    end
  end
end
