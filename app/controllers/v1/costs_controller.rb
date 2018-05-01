class V1::CostsController < ApplicationController
  def show
    if calculator.valid?
      render json: {
        cost: calculator.cost,
        shortest_route: calculator.shortest_route
      }, status: 200
    else
      render json: {
        errors: calculator.errors.full_messages
      }, status: 422
    end
  end

  private

  def calculator
    @calculator ||= CostCalculator.new(
      params.fetch(:origin, nil),
      params.fetch(:destination, nil),
      params.fetch(:weight, nil)
    )
  end
end
