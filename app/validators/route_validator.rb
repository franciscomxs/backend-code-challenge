class RouteValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, 'Invalid route') if record.shortest_route.empty?
  end
end
