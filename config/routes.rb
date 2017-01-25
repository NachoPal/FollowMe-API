Rails.application.routes.draw do

  root to: 'home#index'

  constraints subdomain: 'api' do
   namespace :v1 do
      post '/sign-up', to: 'user#sign_up', as: :sign_up
      post '/log-in', to: 'user#log_in', as: :log_in
    end
  end
end
