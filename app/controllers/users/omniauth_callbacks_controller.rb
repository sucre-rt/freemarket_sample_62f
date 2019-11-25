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

      # 遷移先のビューで必要なデータ
      @status1 ="active"
      @years = []
        Date.today.year.downto(1900){ |year|
          @years << year
        }
      @days = []
      for day in 1..31 do
        if day.to_s.length == 1
          @days << "0" + "#{day}"
        else
          @days << day
        end
      end
      render "/signup/registration"
    end
  end

  def failure
    redirect_to root_path and return
  end

end
