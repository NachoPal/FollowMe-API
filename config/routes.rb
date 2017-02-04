Rails.application.routes.draw do

  root to: 'home#index'

  constraints subdomain: 'api' do
   namespace :v1 do
      post '/sign-up', to: 'user#sign_up', as: :sign_up
      post '/log-in', to: 'user#log_in', as: :log_in

      get '/user/:user_id/trips', to: 'trip#index', as: :user_trip_index
      get '/user/:user_id/trip/:trip_id', to: 'trip#show', as: :user_trip_show
      get '/trip/create', to: 'trip#create', as: :user_trip_create
      get '/trip/update', to: 'trip#update', as: :user_trip_update
      get '/trip/destroy', to: 'trip#destroy', as: :user_trip_destroy

    end
  end
end
