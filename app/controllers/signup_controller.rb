class SignupController < ApplicationController

  def index
  end

  def registration
    @status1 ="active"

    @user = User.new
  end

  def sms_confirmation           #電話番号確認
    @status1 ="through"
    @status2 ="active"

    session[:uid] = user_params[:uid]
    session[:provider] = user_params[:provider]


    if session[:uid].blank?
      session[:nickname] = user_params[:nickname]
      session[:email] = user_params[:email]
      session[:password] = user_params[:password]
      session[:family_name] = user_params[:family_name]
      session[:first_name] = user_params[:first_name]
      session[:family_name_cana] = user_params[:family_name_cana]
      session[:first_name_cana] = user_params[:first_name_cana]
      session[:birthday] = user_params[:birthday]
      @user = User.new
    else
      # SNSでログインした際に、パスワードを自動で発行させる
      number = [*0..9].sample(2)*''   # 数字を2つランダムで取り出す
      alpha = [*'A'..'Z', *'a'..'z'].sample(5)*''   #アルファベットをランダムで5つ取り出す
      password = (number + alpha).split("").shuffle.join    # 取り出した数字と英字をシャッフル
      session[:nickname] = user_params[:nickname]
      session[:email] = user_params[:email]
      session[:password] = password
      session[:family_name] = user_params[:family_name]
      session[:first_name] = user_params[:first_name]
      session[:family_name_cana] = user_params[:family_name_cana]
      session[:first_name_cana] = user_params[:first_name_cana]
      session[:birthday] = user_params[:birthday]
      @user = User.new
    end
  end

  def sms
    @status1 ="through"
    @status2 ="active"

    session[:telphone] = user_params[:telphone]
    @user = User.new
  end

  def address
    @status1 ="through"
    @status2 ="through"
    @status3 ="active"

    @user = User.new
    @user.build_adress
  end

  def credit_card
    @status1 ="through"
    @status2 ="through"
    @status3 ="through"
    @status4 ="active"

    @user = User.new
  end

  def done
    @status1 ="through"
    @status2 ="through"
    @status3 ="through"
    @status4 ="through"
    @status5 ="active"
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
    # @user.build_address(user_params[:address_attributes])
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
        address_attributes: [:family_name, :first_name, :amily_name_cana, :first_name_cana, :postal_code, :prefecture, :city, :address, :user]
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
      ).merge(
        uid: params[:user][:sns_credential][:uid],
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
