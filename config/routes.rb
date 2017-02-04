Rails.application.routes.draw do

  root to: 'home#index'

  constraints subdomain: 'api' do
    namespace :v1 do
      #AUTH
      post '/sign-up', to: 'user#sign_up', as: :sign_up
      post '/log-in', to: 'user#log_in', as: :log_in

      #TRIP
      get '/user/:user_id/trips', to: 'trip#index', as: :user_trip_index
      get '/user/:user_id/trip/:trip_id', to: 'trip#show', as: :user_trip_show
      post '/trip/create', to: 'trip#create', as: :user_trip_create
      post '/trip/update', to: 'trip#update', as: :user_trip_update
      post '/trip/destroy', to: 'trip#destroy', as: :user_trip_destroy

      #DAY

    end
  end
end
