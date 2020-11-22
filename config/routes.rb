Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      post '/events/:id/rsvp', to: 'events#rsvp'

      resources :events, except: [:new, :edit]
      
      get '/users/auth', to: 'users#profile'
      get '/users', to: 'users#index'
      post '/users', to: 'users#create'
      post '/login', to: 'auth#create'

      get '/parks', to: 'parks#index'

      get '/comments', to: 'comments#index'
      post '/comments', to: 'comments#create'
      delete '/comments/:id', to: 'comments#destroy'

    end
  end
end
