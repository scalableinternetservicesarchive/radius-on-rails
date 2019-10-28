Rails.application.routes.draw do
  resources :users
  root 'users#index'

  get 'signup' => 'sign_up#index'
end
