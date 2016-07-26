Rails.application.routes.draw do
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'porownanie' => 'javascript#porownanie'
  get 'slajdowisko' => 'javascript#slajdowisko'
  get 'szubienica' => 'javascript#szubienica'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers # zeby zobaczyc followersow/followingow
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy, :index]
  resources :relationships, only: [:create, :destroy]

end
