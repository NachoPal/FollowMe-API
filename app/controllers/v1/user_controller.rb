module V1
  class UserController < ApplicationController

    def sign_up
      begin
        @user = User.new(user_params)
      rescue Exception
        render json: {status: 'error', reason: 'Invalid params'}
      end

      if valid_passwords? && @user.valid?
          @user.save_and_update_password(encrypt_password(params[:password]))
          render json: {status: 'success'}
      else
        render json: {status: 'error', reason: @user.errors}
      end
    end

    def log_in

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

    def valid_passwords?
      password = params[:password]
      password_confirmation = params[:password_confirmation]

      @user.errors.add_on_blank :password unless password.present?
      @user.errors.add_on_blank :password_confirmation unless password_confirmation.present?
      @user.errors[:password] = 'is too short' unless password.size >= 6
      @user.errors[:password] = 'is too long' unless password.size <= 20
      @user.errors[:password_confirmation] = 'does not match' unless password == password_confirmation

      !@user.errors.keys.include?(:password) && !@user.errors.keys.include?(:password_confirmation)
    end

    def encrypt_password(password)
      BCrypt::Password.create(password)
    end
  end
end