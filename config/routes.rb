Rails.application.routes.draw do 

  devise_for :users 
  devise_scope :user do
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :destroy, :accept] do
      member do
          put :accept
      end
  end
  resources :posts, only: [:create, :edit, :update, :destroy]
  resources :activities, only: [:index]
end
