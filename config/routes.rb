Rails.application.routes.draw do
  devise_for :admin_users
  namespace :admin do
    resources :moods, only: [ :index, :show ]
    resources :user_ips, only: [ :index, :show ]

    root to: "moods#index"
  end
  namespace :api do
    namespace :v1 do
      get "moods/create"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :moods, only: [ :create, :index ]
    end
  end
end
