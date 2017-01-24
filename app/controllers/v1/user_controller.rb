module V1
  class UserController < ApplicationController
    def sign_up
      User.create()
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