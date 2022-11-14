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

  describe '#tall_enough?' do
    it 'returns a boolean based on height of visitor' do
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor3 = Visitor.new('Penny', 64, '$15')

      expect(visitor1.tall_enough?(54)).to be true
      expect(visitor2.tall_enough?(54)).to be false
      expect(visitor3.tall_enough?(54)).to be true
      expect(visitor1.tall_enough?(64)).to be false
    end
  end

  describe '#spend_money' do
    it 'removes money from @spending_money' do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      visitor1.spend_money(1)
      expect(visitor1.spending_money).to eq(9)
      visitor1.spend_money(3)
      expect(visitor1.spending_money).to eq(6)
    end
  end
end
