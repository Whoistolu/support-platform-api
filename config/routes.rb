Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  devise_for :users,
    controllers: {
      sessions: "api/users/sessions",
      registrations: "api/users/registrations",
      confirmations: "api/users/confirmations"
    }

  get "/tickets/export.csv", to: "exports#tickets_csv"

  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"
end
