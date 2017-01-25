module V1
  class UserController < AuthenticationController

    def sign_up
      begin
        user = User.new(user_params)
      rescue Exception
        render json: {status: 'error', reason: 'Invalid params'}
      end

      if user.valid? && valid_passwords?(user)
          user.save_and_update_password(params[:password])
          render json: {status: 'success'}
      else
        render json: {status: 'fail', reason: user.errors}
      end
    end

    def log_in
      if params[:email].present?
        user = User.where(email: params[:email]).first

        if user.present?
          if params[:password].present?
            response = user.authenticate(params[:password])
            render json: response
          else
            render json: {status: 'fail', reason: {password: 'can not be blank'}}
          end
        else
          render json: {status: 'fail', reason: {email: 'not registered'}}
        end
      else
        render json: {status: 'fail', reason: {email: 'can not be blank'}}
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
      params.permit(:email, :name)
    end

    def valid_passwords?(user)
      password = params[:password]
      password_confirmation = params[:password_confirmation]

      user.errors.add_on_blank :password unless password.present?
      user.errors.add_on_blank :password_confirmation unless password_confirmation.present?
      user.errors[:password] = 'is too short' unless password.size >= 6
      user.errors[:password] = 'is too long' unless password.size <= 20
      user.errors[:password_confirmation] = 'does not match' unless password == password_confirmation

      !user.errors.keys.include?(:password) && !user.errors.keys.include?(:password_confirmation)
    end


  end
end