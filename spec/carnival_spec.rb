require 'rspec'
require './lib/visitor'
require './lib/ride'
require './lib/carnival'

describe Carnival do
  describe '#initialize' do
    it 'instantiates correctly' do
      carnival = Carnival.new('Ride Fest', 4)

      expect(carnival).to be_a Carnival
      expect(carnival.name).to eq('Ride Fest')
      expect(carnival.duration).to eq(4)
      expect(carnival.rides).to eq([])
    end
  end

  describe '#add_ride' do
    it 'adds a ride to @rides' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })

      carnival.add_ride(ride1)
      expect(carnival.rides).to eq([ride1])
      carnival.add_ride(ride2)
      expect(carnival.rides).to eq([ride1, ride2])
    end
  end

  describe '#most_popular' do
    it 'returns the most popular ride at the carnival' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride2.board_rider(visitor3)

      expect(carnival.most_popular).to eq(ride1)
    end
  end

  describe '#most_profitable' do
    it 'returns the most profitable ride at the carnival' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      ride3 = Ride.new({ name: 'Bad Ride', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride2.board_rider(visitor3)

      expect(carnival.most_profitable).to eq(ride2)
    end
  end

  describe '#total_revenue' do
    it 'returns the sum of all rides revenues' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride2.board_rider(visitor3)

      expect(carnival.total_revenue).to eq(5)
    end
  end
end
