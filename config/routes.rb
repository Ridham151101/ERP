Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, skip: [:registrations]

  devise_scope :user do
    # Allow users to edit/update but not sign up
    get 'users/edit', to: 'users/registrations#edit', as: :edit_user_registration
    put 'users', to: 'users/registrations#update', as: :user_registration
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :employees do
    member do
      get 'change_password'
      patch 'update_password'
    end
  end
  resources :bills, only: [:index, :new, :create, :edit, :update]
  resources :admin_bills, only: [:index, :update]

  # Defines the root path route ("/")
  root 'employees#index'
end
