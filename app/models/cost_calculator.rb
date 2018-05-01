class CostCalculator < Struct.new(:origin, :destination, :weight)
  include ActiveModel::Validations
  validates :origin, :destination, :weight, presence: true

  validates :weight, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than_or_equal_to: 50
  }

  validates_with RouteValidator

  delegate :shortest_route, :shortest_distance, to: :algorithm

  COST_CONSTANT = 0.15

  def cost
    algorithm.shortest_distance * Integer(weight) * COST_CONSTANT
  end

  def algorithm
    @algorithm ||= Dijkstra.algorithm(graph, origin, destination)
  end

  def graph
    @graph ||= Distance.pluck(:origin, :destination, :distance)
  end
end
