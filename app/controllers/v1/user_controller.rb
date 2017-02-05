module V1
  class UserController < AuthenticationController

    def sign_up
      begin
        user = User.new(user_params)
      rescue Exception
        render json: {}, status: 500
      end

      if user.valid?
          user.save_and_update_password(params[:password])
          render json: {}, status: 201
      else
        render json: {status: 'error', reason: user.errors}
      end
    end

    def log_in
      if params[:email].present?
        user = User.where(email: params[:email]).first

        if user.present?
          if params[:password].present?
            response = user.authenticate(params[:password])
            render json: response[:json], status: response[:status]
          else
            render json: {status: 'error', reason: {password: 'can not be blank'}}
          end
        else
          render json: {status: 'error', reason: {email: 'not registered'}}
        end
      else
        render json: {status: 'error', reason: {email: 'can not be blank'}}
      end
    end

    def log_out

    end

    def delete

    end

    def reset_password

    end

    private

    def user_params
      params.permit(:email, :name, :password, :password_confirmation)
    end
  end
end