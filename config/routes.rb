Rails.application.routes.draw do
  namespace :v1, default: { format: 'json' } do
    resource :distance, only: [:create]
    resource :cost, only: [:show]
  end
end
