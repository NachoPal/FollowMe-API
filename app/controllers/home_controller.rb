class HomeController < ApplicationController
  def index
    render json: {index: 'index'}
  end
end