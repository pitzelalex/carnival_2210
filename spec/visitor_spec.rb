require 'rspec'
require './lib/visitor'

describe Visitor do
  describe '#initialize' do
    it 'instantiates correctly' do
      visitor = Visitor.new('Bruce', 54, '$10')

      expect(visitor).to be_a Visitor
      expect(visitor.name).to eq('Bruce')
      expect(visitor.height).to eq(54)
      expect(visitor.spending_money).to eq(10)
      expect(visitor.preferences).to eq([])
    end
  end

  describe '#add_preference' do
    it 'adds a preference to the preferences array' do
      visitor = Visitor.new('Bruce', 54, '$10')
      
      visitor.add_preference(:gentle)
      expect(visitor.preferences).to eq([:gentle])
      visitor.add_preference(:water)
      expect(visitor.preferences).to eq([:gentle, :water])
    end
  end
end
