Rails.application.routes.draw do
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

  # Follows
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  # Create posts and show feed
  resources :posts, :only => [:new, :create, :destroy]
  get 'feed' => 'users#feed', as: 'feed'

  # Messaging
  resources :conversations, path: 'chats' do
    resources :messages
  end

  # Root path configuration
  authenticated :user do
    root 'users#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
