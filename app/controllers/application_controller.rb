class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def configure_permitted_parameters
    #Devise sign_up
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :username, :password_confirmation, :remember_me, :avatar, :profile_background_avatar)}
    #Devise update
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :username, :password_confirmation, :remember_me, :avatar, :profile_background_avatar, :current_password)}
  end
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end

  def after_sign_in_path_for(resource_or_scope)
    root_url
  end
end
