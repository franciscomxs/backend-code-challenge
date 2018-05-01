class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing do
    head 400
  end
end
