Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'boards#index'
  resource :profiles
  resources :boards do
    resources :tasks do
      resources :comments
    end
  end
  resource :profile
end
