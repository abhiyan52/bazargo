Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  get '/profile', to: 'homes#profile'
  post '/sign_in', to: 'homes#sign_in_user'
  get '/sign_in_form', to: 'homes#sign_in_form'
  get '/sign_up_form', to: 'homes#sign_up_form'
  post '/sign_up',to: 'homes#sign_up_user'
end
