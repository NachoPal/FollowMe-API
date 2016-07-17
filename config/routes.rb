Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "home#index"

  constraints subdomain: 'api' do
    #devise_for :users
    namespace :v1 do
      post '/sign-up', to: 'user#sign_up', as: :sign_up
    end
  end
end
