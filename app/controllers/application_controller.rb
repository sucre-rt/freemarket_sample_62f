class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters , if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_cana, :first_name_cana, :birthday, :telphone, :profile, :image, :point])
  end
end
