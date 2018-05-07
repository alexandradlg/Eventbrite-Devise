Rails.application.routes.draw do
  root 'static#home'
  get 'events/new'
  get 'events/create'
  devise_for :users
  resources :users, :only => [:show]
  
  resources :events do 
    post '/subscribe', to: 'events#subscribe'
    post '/unsubscribe', to: 'events#unsubscribe'
    get '/invite', to: 'events#invite' 
    post '/invite', to: 'events#invite'     
    post '/invite/:id', to: 'events#subscribe_friends', as: 'user_invited'
  end

  resources :charges
end
