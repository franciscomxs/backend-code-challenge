require 'rails_helper'

RSpec.describe Distance, type: :model do
  describe 'validations' do
    [:origin, :destination, :distance].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    it { is_expected.to validate_numericality_of(:distance).only_integer.
      is_greater_than(0).
      is_less_than_or_equal_to(100_000)
     }
  end
end
