module V1
  class UserController < ApplicationController
    def sign_up
      puts 'hola'
      render json: {hola: 'hola'}
    end

    def log_in

    end

    def log_out

    end

    def delete

    end

    def reset_password

    end
  end
end