Rails.application.routes.draw do
  resources :contacts, only: [:new, :create]


  # resources :comments

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :projects, only: :index

  resources :articles do
    resources :comments
  end

  get '/about' => 'static#about', as: 'about_me'
  root 'static#index', as: "home"
end
