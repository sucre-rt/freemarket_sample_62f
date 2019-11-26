class SignupController < ApplicationController
  include SignupHelper
  before_action :set_user, only: [:registration, :sms_confirmation, :sms, :address, :credit_card]

  def index
  end

  def registration
    status_bar("active", "", "", "", "")
    
  end

  def sms_confirmation           #電話番号確認
    status_bar("through", "active", "", "", "")

    session[:uid]       = user_params[:uid]
    session[:provider]  = user_params[:provider]


    if session[:uid].blank?
      session[:nickname]          = user_params[:nickname]
      session[:email]             = user_params[:email]
      session[:password]          = user_params[:password]
      session[:family_name]       = user_params[:family_name]
      session[:first_name]        = user_params[:first_name]
      session[:family_name_cana]  = user_params[:family_name_cana]
      session[:first_name_cana]   = user_params[:first_name_cana]
      session[:birthday]          = user_params[:birthday]
    else
      # SNSでログインした際に、パスワードを自動で発行させる
      number    = [*0..9].sample(2)*''   # 数字を2つランダムで取り出す
      alpha     = [*'A'..'Z', *'a'..'z'].sample(5)*''   #アルファベットをランダムで5つ取り出す
      password  = (number + alpha).split("").shuffle.join    # 取り出した数字と英字をシャッフル
      session[:nickname]          = user_params[:nickname]
      session[:email]             = user_params[:email]
      session[:password]          = password
      session[:family_name]       = user_params[:family_name]
      session[:first_name]        = user_params[:first_name]
      session[:family_name_cana]  = user_params[:family_name_cana]
      session[:first_name_cana]   = user_params[:first_name_cana]
      session[:birthday]          = user_params[:birthday]
    end

  end

  def sms
    status_bar("through", "active", "", "", "")

    session[:telphone] = user_params[:telphone]
  end

  def address
    status_bar("through", "through", "active", "", "")

    @prefecture = User.set_prefecture
    @user.build_address
  end

  def credit_card
    status_bar("through", "through", "through", "active", "")

    @user.build_card

    #ここからアドレス
    addreses = user_params[:address_attributes]                             #変数に入れてる
    session[:ad_family_name]      = addreses[:family_name]
    session[:ad_first_name]       = addreses[:first_name]
    session[:ad_family_name_cana] = addreses[:family_name_cana]
    session[:ad_first_name_cana]  = addreses[:first_name_cana]
    session[:postal_code]         = addreses[:postal_code]
    session[:prefecture]          = addreses[:prefecture]
    session[:city]                = addreses[:city]
    session[:address]             = addreses[:address]
    session[:building]            = addreses[:building]
    session[:tel]                 = addreses[:tel]
    #ここまでアドレス
  end

  def done
    status_bar("through", "through", "through", "through", "active")
  end

  def create

    @user = User.new(
      nickname:         session[:nickname],
      email:            session[:email],
      password:         session[:password],
      family_name:      session[:family_name],
      first_name:       session[:first_name],
      family_name_cana: session[:family_name_cana],
      first_name_cana:  session[:first_name_cana],
      birthday:         session[:birthday],
      telphone:         session[:telphone]
    )
    @user.build_address(
      family_name:      session[:ad_family_name],
      first_name:       session[:ad_first_name],
      family_name_cana: session[:ad_family_name_cana],
      first_name_cana:  session[:ad_first_name_cana],
      postal_code:      session[:postal_code],
      prefecture:       session[:prefecture],
      city:             session[:city],
      address:          session[:address],
      building:         session[:building],
      tel:              session[:tel]
    )

    if @user.save && session[:uid].blank?
      # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to done_signup_index_path
    elsif @user.save && session[:uid]
      session[:id] = @user.id
      SnsCredential.create(
        uid:        session[:uid],
        provider:   session[:provider],
        user_id:    session[:id]
      )
      redirect_to done_signup_index_path
    else
      @status1 = "active"
      redirect_to controller: :signup, action: :registration
    end

  end

  # ユーザー情報確認ページ addressコントローラマージされたらそっちに移す
  def edit
  end

  # ユーザープロフィールページ
  def profile
  end

  def update

    if current_user.update(update_params)
      flash[:notice] = "変更しました。"
      redirect_to profile_signup_path
    else 
      flash[:notice] = "変更に失敗しました。"
      redirect_to profile_signup_path
    end
    
  end

  private

  def set_user
    @user = User.new
  end

 # 許可するキーを設定します
  def user_params

    if params[:user][:sns_credential].blank?
      params.require(:user).permit(
        :nickname,
        :email,
        :password,
        :family_name,
        :first_name,
        :family_name_cana,
        :first_name_cana,
        :birthday,
        :telphone,
        address_attributes:[
          :id,
          :family_name, 
          :first_name, 
          :family_name_cana, 
          :first_name_cana, 
          :postal_code, 
          :prefecture, 
          :city, 
          :address, 
          :building, 
          :tel
        ]
      )
    else
      params.require(:user).permit(
        :nickname,
        :email,
        :password,
        :family_name,
        :first_name,
        :family_name_cana,
        :first_name_cana,
        :birthday,
        :telphone,
        address_attributes: [
          :id, 
          :family_name, 
          :first_name, 
          :family_name_cana, 
          :first_name_cana, 
          :postal_code, 
          :prefecture, 
          :city, 
          :address, 
          :building, 
          :tel]
      ).merge(
        uid:      params[:user][:sns_credential][:uid],
        provider: params[:user][:sns_credential][:provider]
      )
    end

  end

  def update_params
    params.require(:user).permit(
      :nickname,
      :profile
    )
  end

end
