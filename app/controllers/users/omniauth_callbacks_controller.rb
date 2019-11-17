# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # protect_from_forgery with: :nullsession

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    # 引数(provider)には、facebook,googleなどのプロバイダ名が入っている

    @omniauth = request.env['omniauth.auth']
    # request.env['omniauth.auth']に、provider・uid・info{"email","name","image"}・credentialsなどの全ての情報が入っている

    info = User.find_oauth(@omniauth)  # userモデルのfind_oauthメソッドの呼び出し
    @user = info[:user]

    if @user.persisted?
      # すでにSNSを利用してユーザー登録している場合は、サインインさせる
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      # SNS情報が登録されていなければサインアップさせる
      @sns = info[:sns]

      # SNSでログインした際に、パスワードを自動で発行させる
      # number = [*0..9].sample(2)*''   # 数字を2つランダムで取り出す
      # alpha = [*'A'..'Z', *'a'..'z'].sample(5)*''   #アルファベットをランダムで5つ取り出す
      # password = (number + alpha).split("").shuffle.join    # 取り出した数字と英字をシャッフル
      # @user[:encrypted_password] = password

      @status1 ="active"
      render "/signup/registration"
    end
  end

  def failure
    redirect_to root_path and return
  end

end
