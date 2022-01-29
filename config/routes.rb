Rails.application.routes.draw do
  
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  get '/member-data', to: 'members#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy, :index]
      resources :likes, only: [:new, :create]
    end
  end
  get 'new_post', to: 'posts#new'
  get 'new_test', to: 'tests#show'
end
