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

  def board_rider(visitor)
    return unless would_ride?(visitor)

    visitor.spend_money(@admission_fee)
    log_rider(visitor)
    @total_revenue += @admission_fee
  end

  def log_rider(visitor)
    @rider_log[visitor] ||= 0
    @rider_log[visitor] += 1
  end

  def ridden_count
    return 0 if @rider_log == {}
    @rider_log.values.sum
  end
end
