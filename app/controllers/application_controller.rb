class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token, if: request.format.json?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = %i[username password current_password user_role user_role_id masla_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
