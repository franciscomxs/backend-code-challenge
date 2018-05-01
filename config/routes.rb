Rails.application.routes.draw do
  namespace :v1, default: { format: 'json' } do
    resource :distance, only: [:create]
  end
end
