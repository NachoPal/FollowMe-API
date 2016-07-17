class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def flash

  end
end
