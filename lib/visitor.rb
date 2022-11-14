class Visitor
  attr_reader :name,
              :height,
              :spending_money,
              :preferences

  def initialize(name, height, money)
    @name = name
    @height = height
    @spending_money = money[1..].to_i
    @preferences = []
  end

  def add_preference(pref)
    @preferences.push(pref)
  end
end
