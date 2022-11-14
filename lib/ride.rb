class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(data)
    @name = data[:name]
    @min_height = data[:min_height]
    @admission_fee = data[:admission_fee]
    @excitement = data[:excitement]
    @total_revenue = 0
    @rider_log = {}
  end

  def would_ride?(visitor)
    visitor.tall_enough?(@min_height) && visitor.preferences.include?(@excitement)
  end
end
