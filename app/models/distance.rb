class Distance < ApplicationRecord
  validates :origin, :destination, :distance, presence: true
  validates :distance, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than_or_equal_to: 100_000
  }
end
