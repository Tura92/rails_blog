Rails.application.routes.draw do
  
  root 'home#index'

  get 'articles/index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :articles do
    resources :comments
    collection { post :import }
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
 
end
