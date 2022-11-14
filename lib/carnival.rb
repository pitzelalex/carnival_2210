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
    max_rides = @rides.sort do |ride|
      -ride.ridden_count
    end
    max_rides.first
  end
end
