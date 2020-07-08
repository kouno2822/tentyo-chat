Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", to:  "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy" 
  end
  root 'groups#index'
  resources :groups do
    member do
      get :join
    end
    resources :messages
  end
    
end
