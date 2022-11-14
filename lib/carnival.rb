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

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def unique_visitors
    unique = []
    rides.each do |ride|
      ride.rider_log.each_key do |rider|
        unique << rider unless unique.include?(rider)
      end
    end
    unique.sort_by do |rider|
      rider.name
    end
  end

  def visitor_count
    unique_visitors.count
  end

  def favorite_ride(visitor)
    ridden = {}
    @rides.each do |ride|
      next unless ride.rider_log.keys.include?(visitor)

      ridden[ride] = ride.rider_log[visitor]
    end
    ridden.max_by{ |rider, count| count }.first.name
  end

  def money_spent(visitor)
    # sum is bugging out, switching to each.
    # @rides.sum do |ride|
    #   return 0 unless ride.rider_log.keys.include?(visitor)
    #   ride.rider_log[visitor] * ride.admission_fee
    # end
    count = 0
    @rides.each do |ride|
      next unless ride.rider_log.keys.include?(visitor)
      count += ride.rider_log[visitor] * ride.admission_fee
    end
    return count
  end

  def visitor_summary(visitor)
    summary = {
      favorite_ride: favorite_ride(visitor),
      money_spent: money_spent(visitor)
    }
  end

  def summary
    visitors_summary = {}
    rides_summary = {}
    unique_visitors.each do |visitor|
      visitors_summary["#{visitor.name}"] = visitor_summary(visitor)
    end
    @rides.each do |ride|
      rides_summary["#{ride.name}"] = {
        riders: ride.rider_log.keys.map { |rider| rider.name }.sort,
        total_revenue: ride.total_revenue
      }
    end
    {
      visitor_count: visitor_count,
      revenue_earned: total_revenue,
      visitors: visitors_summary,
      rides: rides_summary
    }
  end
end
