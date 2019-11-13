Rails.application.routes.draw do
  resources :posts
  devise_for :users, path: '', path_names: { 
    sign_in: 'login',
    sign_out: 'logout'
  }, controllers: { 
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Show user profiles
  resources :users, :only => [:show]
  get 'profile' => 'users#show'
  put 'users/:id/update_location' => 'users#update_location', as: 'update_location'
  
  # Create posts and show feed
  resources :microposts, :only => [:new]
  get 'feed' => 'users#feed', as: 'feed'

  # Root path configuration
  authenticated :user do
    root 'users#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
