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
end
