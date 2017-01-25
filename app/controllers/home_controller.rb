class HomeController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: {status: :authorized, user: @current_user}
  end
end