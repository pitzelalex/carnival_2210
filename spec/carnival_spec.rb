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

  describe '#unique_visitors' do
    it 'returns an array of unique visitor names' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:intense)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      visitor3.add_preference(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor3)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor1)

      expect(carnival.unique_visitors).to eq([visitor1, visitor3, visitor2])
    end
  end

  describe '#favorite_ride' do
    it 'returns the name of a visitors favorite ride' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:intense)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)

      expect(carnival.favorite_ride(visitor1)).to eq('Carousel')
    end
  end

  describe '#money_spent' do
    it 'returns the money spent by a visitor' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:intense)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)

      expect(carnival.money_spent(visitor1)).to eq(5)
    end
  end

  describe '#visitor_summary' do
    it 'returns a summary of a visitor' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:intense)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      visitor3.add_preference(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor3)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor1)

      expect(carnival.visitor_summary(visitor1)).to eq(
        {
          favorite_ride: 'Carousel',
          money_spent: 5
        }
      )
      expect(carnival.visitor_summary(visitor2)).to eq(
        {
          favorite_ride: 'Carousel',
          money_spent: 1
        }
      )
    end
  end

  describe '#visitor_count' do
    it 'returns an count of unique visitors' do
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

      expect(carnival.visitor_count).to eq(3)
    end
  end

  describe '#summary' do
    it 'returns a hash summary of the carnival' do
      carnival = Carnival.new('Ride Fest', 4)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Coaster', min_height: 52, admission_fee: 3, excitement: :intense })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)
      visitor1.add_preference(:intense)
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor2.add_preference(:gentle)
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor3.add_preference(:intense)
      visitor3.add_preference(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor3)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor3)
      ride2.board_rider(visitor1)

      expect(carnival.summary).to eq(
        {
          visitor_count: 3,
          revenue_earned: 13,
          visitors: {
            'Bruce' => {
              favorite_ride: 'Carousel',
              money_spent: 5
            },
            'Tucker' => {
              favorite_ride: 'Carousel',
              money_spent: 1
            },
            'Penny' => {
              favorite_ride: 'Coaster',
              money_spent: 7
            }
          },
          rides: {
            'Carousel' => {
              riders: ['Bruce', 'Penny', 'Tucker'],
              total_revenue: 4
            },
            'Coaster' => {
              riders: ['Bruce', 'Penny'],
              total_revenue: 9
            }
          }
        }
      )
    end
  end
end
