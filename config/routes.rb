Rails.application.routes.draw do
  devise_for :users
  # Fix this routing
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'edit', to: 'users/registrations#edit'
  end
  # resources :users, :only => [:show]

  root 'users#index'
  get 'profile' => 'users#show'
end
