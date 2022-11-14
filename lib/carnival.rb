class Carnival
  attr_reader :name,
              :duration,
              :rides

  def initialize(name, duration)
    @name = name
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular
    max_rides = @rides.sort_by do |ride|
      -ride.ridden_count
    end
    max_rides.first
  end

  def most_profitable
    max_profit = @rides.sort_by do |ride|
      -ride.total_revenue
    end
    max_profit.first
  end
end
