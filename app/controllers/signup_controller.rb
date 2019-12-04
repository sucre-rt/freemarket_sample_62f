class SignupController < ApplicationController
  include SignupHelper, CardHelper
  before_action :set_user, only: [:registration, :address, :credit_card]

  def index
  end

  def registration
    status_bar("active", "", "", "", "")
  end

  def sms_confirmation           #電話番号確認
    status_bar("through", "active", "", "", "")

    # SNSの情報を格納
    session[:uid]       = user_params[:uid]
    session[:provider]  = user_params[:provider]
    # SNSでログインした際に、パスワードを自動で発行させる
    number    = [*0..9].sample(2)*''   # 数字を2つランダムで取り出す
    alpha     = [*'A'..'Z', *'a'..'z'].sample(5)*''   #アルファベットをランダムで5つ取り出す
    password  = (number + alpha).split("").shuffle.join    # 取り出した数字と英字をシャッフル

    # バリデーションにかけるために仮インスタンスを作成
    @user = User.new(
      nickname:         user_params[:nickname],
      email:            user_params[:email],
      password:         session[:uid].blank? ? user_params[:password] : password,
      family_name:      user_params[:family_name],
      first_name:       user_params[:first_name],
      family_name_cana: user_params[:family_name_cana],
      first_name_cana:  user_params[:first_name_cana],
      birthday:         user_params[:birthday],
      telphone:         "00000000000"
    )

    if @user.valid?   # １ページ目のバリデーションチェック
      session[:nickname]          = user_params[:nickname]
      session[:email]             = user_params[:email]
      session[:password]          = session[:uid].blank? ? user_params[:password] : password
      session[:family_name]       = user_params[:family_name]
      session[:first_name]        = user_params[:first_name]
      session[:family_name_cana]  = user_params[:family_name_cana]
      session[:first_name_cana]   = user_params[:first_name_cana]
      session[:birthday]          = user_params[:birthday]
      session[:telphone]          = ""    # 仮の値を削除

      # 仮の値を消すために再度仮インスタンスを生成
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
    else
      status_bar("active", "", "", "", "")
      render registration_signup_index_path
    end

  end

  def sms
    status_bar("through", "active", "", "", "")

    # バリデーションにかけるために仮インスタンスを作成
    @user = User.new(
      nickname:         session[:nickname],
      email:            session[:email],
      password:         session[:password],
      family_name:      session[:family_name],
      first_name:       session[:first_name],
      family_name_cana: session[:family_name_cana],
      first_name_cana:  session[:first_name_cana],
      birthday:         session[:birthday],
      telphone:         user_params[:telphone]
    )
    if @user.valid?   # 電話番号のバリデーションチェック
      session[:telphone] = user_params[:telphone]
    else
      status_bar("through", "active", "", "", "")
      render sms_confirmation_signup_index_path
    end
  end

  def address
    status_bar("through", "through", "active", "", "")

    @prefecture = User.set_prefecture
    @address = @user.build_address
  end

  def credit_card
    status_bar("through", "through", "through", "active", "")
    
    addresses = user_params[:address_attributes]   # addressのみのparamsを取得し変数に格納
    # 発送元住所のバリデーションチェックのためにインスタンスを生成
    @address = @user.build_address(
      family_name:      addresses[:family_name],
      first_name:       addresses[:first_name],
      family_name_cana: addresses[:family_name_cana],
      first_name_cana:  addresses[:first_name_cana],
      postal_code:      addresses[:postal_code],
      prefecture:       addresses[:prefecture],
      city:             addresses[:city],
      address:          addresses[:address],
      building:         addresses[:building],
      tel:              addresses[:tel]
    )
    if @address.valid?    # 発送元住所のバリデーションチェック
      session[:ad_family_name]      = addresses[:family_name]
      session[:ad_first_name]       = addresses[:first_name]
      session[:ad_family_name_cana] = addresses[:family_name_cana]
      session[:ad_first_name_cana]  = addresses[:first_name_cana]
      session[:postal_code]         = addresses[:postal_code]
      session[:prefecture]          = addresses[:prefecture]
      session[:city]                = addresses[:city]
      session[:address]             = addresses[:address]
      session[:building]            = addresses[:building]
      session[:tel]                 = addresses[:tel]
    else
      status_bar("through", "through", "active", "", "")
      @prefecture = User.set_prefecture
      render address_signup_index_path
    end

  end

  def done
    status_bar("through", "through", "through", "through", "active")
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    # ユーザーの生成
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
    # 配送元住所の生成
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
    # クレジットカードの生成
    customer = Payjp::Customer.create(
      card:  params['payjp_token']
    )
    @user.build_card(
      customer_id:  customer.id,
      card_id:      customer.default_card
    )

    if @user.save && session[:uid].blank?
      sign_in_and_redirect @user
    elsif @user.save && session[:uid]
      session[:user_id] = @user.id
      SnsCredential.create(
        uid:        session[:uid],
        provider:   session[:provider],
        user_id:    session[:user_id]
      )
      sign_in_and_redirect @user
    else
      @status1 = "active"
      redirect_to controller: :signup, action: :registration
    end

  end

  # ユーザープロフィールページ
  def profile
  end

  def update
    if current_user.update(update_params)
      flash[:notice] = "変更しました。"
      redirect_to profile_signup_path
    else 
      flash[:alert] = "変更に失敗しました。"
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

  # 新規登録後ログインした状態で登録完了ページにアクセスさせるためのルート定義
  def after_sign_in_path_for(resource)
    done_signup_index_path
  end

end
