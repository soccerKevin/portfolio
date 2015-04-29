Rails.application.routes.draw do
  # resources :comments

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :projects

  resources :articles do
    resources :comments
  end


  root 'static#index'
end
