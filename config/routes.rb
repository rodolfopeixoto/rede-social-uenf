Rails.application.routes.draw do

  root :to => redirect("/users/sign_up")
  
  authenticated :user do
    root to: "pages#home", as: :authenticated_root
  end

  devise_for :users, controllers: {registrations: 'registrations'}
  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :destroy, :accept] do
      member do
          put :accept
      end
  end
  resources :posts, only: [:create, :edit, :update, :destroy]
  resources :activities, only: [:index]
end
