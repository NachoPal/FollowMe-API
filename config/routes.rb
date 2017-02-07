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
      post '/trip',                       to: 'trip#create',  as: :user_trip_create
      patch '/trip',                      to: 'trip#update',  as: :user_trip_update
      delete '/trip/',                    to: 'trip#destroy', as: :user_trip_destroy

      #DAY
      get '/trip/:trip_id/days',          to: 'day#index',    as: :trip_day_index
      get '/trip/:trip_id/day/:day_id',   to: 'day#show',     as: :trip_day_show
      post '/trip/:trip_id/day',          to: 'day#create',   as: :trip_day_create
      patch '/trip/:trip_id/day',         to: 'day#update',   as: :trip_day_update
      delete '/trip/:trip_id/day',        to: 'day#destroy',  as: :trip_day_destroy
    end
  end
end
