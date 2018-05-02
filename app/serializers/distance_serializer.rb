class DistanceSerializer < ActiveModel::Serializer
  attributes :origin, :destination, :distance
end
