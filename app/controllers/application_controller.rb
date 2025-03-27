class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :profile, :blog_url ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :email, :profile, :blog_url ])
  end
end
