Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  devise_for :users

  get "/tickets/export.csv", to: "exports#tickets_csv"

  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"
end
