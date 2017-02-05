class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  def strict_authenticate_request!
    if user_id_in_token?
      @current_user = User.find(@auth_token['user_id'])
    else
      render json: {status: :unauthorized}
      return
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {status: :unauthorized}
  end

  def soft_authenticate_request!
    if user_id_in_token?
      @current_user = User.find(@auth_token['user_id'])
    else
      @current_user = nil
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {status: :unauthorized}
  end

  def is_a_owner_request?(controller)
    case controller.class.name.demodulize
      when 'TripController'
        @current_user.present? ? @current_user.id == params[:user_id].to_i : false
      when 'DayController'
        @current_user.present? ? @current_user.trips.where(id: params[:trip_id]).present? : false
      else
        false
    end
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(@http_token).first
  end

  def user_id_in_token?
    http_token && auth_token && @auth_token['user_id']
  end

  def is_current_user?
    @current_user
  end
end
