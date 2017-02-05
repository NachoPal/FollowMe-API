Rails.application.routes.draw do

  root to: 'home#index'

  constraints subdomain: 'api' do
    namespace :v1 do
      #AUTH
      post '/sign-up',  to: 'user#sign_up', as: :sign_up
      post '/log-in',   to: 'user#log_in',  as: :log_in

      #TRIP
      get '/user/:user_id/trips',         to: 'trip#index',   as: :user_trip_index
      get '/user/:user_id/trip/:trip_id', to: 'trip#show',    as: :user_trip_show
      post '/trip/create',                to: 'trip#create',  as: :user_trip_create
      post '/trip/update',                to: 'trip#update',  as: :user_trip_update
      post '/trip/destroy',               to: 'trip#destroy', as: :user_trip_destroy

      #DAY
      get '/trip/:trip_id/days',          to: 'day#index',    as: :trip_day_index
      get '/trip/:trip_id/day/:day_id',   to: 'day#show',     as: :trip_day_show
      post '/trip/:trip_id/day/create',   to: 'day#create',   as: :trip_day_create
      post '/trip/:trip_id/day/update',   to: 'day#update',   as: :trip_day_update
      post '/trip/:trip_id/day/destroy',  to: 'day#destroy',  as: :trip_day_destroy

    end
  end
end
