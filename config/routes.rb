Rails.application.routes.draw do
  resources :books do
    member do
      post :borrow
      put :return
      post :hold
    end
  end
  resources :transactions
  devise_for :users
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
