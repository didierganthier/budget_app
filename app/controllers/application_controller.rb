class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome, #{current_user.name}!"
    root_path
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome, #{current_user.name}! Your account has been created."
    root_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = 'You have been logged out.'
    root_path
  end
end
