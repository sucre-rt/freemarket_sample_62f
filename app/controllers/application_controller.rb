class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters , if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :configure_category
  before_action :set_category_products

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_cana, :first_name_cana, :birthday, :telphone, :profile, :image, :point])
  end

  def configure_category
    @parents = Category.all.limit(13)
  end
  
  def set_category_products
    @products = Product.all.order("id DESC")
    @women = []
    @men = []
    @home_appliances = []
    @toys = []
    @products.each do |product|
      case product.category.parent.parent.name
      when "レディース"
        @women << product
      when "メンズ"
        @men << product
      when "家電・スマホ・カメラ"
        @home_appliances << product
      when "おもちゃ・ホビー・グッズ"
        @toys << product
      end
    end
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

end
