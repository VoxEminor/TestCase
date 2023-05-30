Rails.application.routes.draw do
  devise_for :users
  scope '/admin' do
    resources :users
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "posts#index"

  resources :posts

end
