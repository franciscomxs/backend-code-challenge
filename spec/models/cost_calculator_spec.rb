require 'rails_helper'

RSpec.describe CostCalculator, type: :model do
  describe 'validations' do
    [:origin, :destination, :weight].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    it { is_expected.to validate_numericality_of(:weight).only_integer.
      is_greater_than(0).
      is_less_than_or_equal_to(50)
     }
  end

  describe '#cost' do
    before do
      create(:distance, origin: 'A', destination: 'B', distance: 100)
      create(:distance, origin: 'B', destination: 'C', distance: 100)
    end

    context 'with existent data' do
      let(:calculator) { CostCalculator.new('A', 'C', 15) }

      # distance * weight * constante
      # 200 * 15 * 0.15 = 450
      it { expect(calculator.cost).to eq(450.0) }
      it { expect(calculator).to be_valid }
    end

    context 'with non existent data' do
      let(:calculator) { CostCalculator.new('A', 'D', 15) }
      it { expect(calculator.cost).to eq(0) }
      it { expect(calculator).to_not be_valid }
    end
  end

  describe 'shortest_route' do
    let(:calculator) { CostCalculator.new('A', 'C', 15) }

    before do
      algorithm = double(:algorithm, shortest_route: 'A - B - C')
      allow(calculator).to receive(:algorithm).and_return(algorithm)
    end

    it { expect(calculator.shortest_route).to eq('A - B - C') }
  end

  describe 'shortest_distance' do
    let(:calculator) { CostCalculator.new('A', 'C', 15) }

    before do
      algorithm = double(:algorithm, shortest_distance: 100)
      allow(calculator).to receive(:algorithm).and_return(algorithm)
    end

    it { expect(calculator.shortest_distance).to eq(100) }
  end
end
