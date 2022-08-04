class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :phone, :role, :group])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :phone, :group])
  end

  public
  def authorize_admin_active
    return unless current_user.role != "ADMIN" and current_user.activated != true
    redirect_to root_path, alert: "Your account hasn't been activated yet"
  end
end
