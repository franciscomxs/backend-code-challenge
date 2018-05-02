class V1::DistancesController < ApplicationController
  def create
    distance = Distance.find_or_initialize_by(distance_key_params)
    distance.assign_attributes(distance_params)
    if distance.save
      render json: distance, status: 201
    else
      render json: { errors: distance.errors.full_messages }, status: 422
    end
  end

  private

  def distance_params
    params.require(:distance).permit(:origin, :destination, :distance)
  end

  def distance_key_params
    params.require(:distance).permit(:origin, :destination)
  end
end
