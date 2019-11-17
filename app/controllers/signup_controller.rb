class SignupController < ApplicationController
  
  def index
  end

  def registration
    @status1 ="active"

    @user = User.new

  end

  def sms_confirmation
    @status1 ="through"
    @status2 ="active"
    binding.pry
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:family_name_cana] = user_params[:family_name_cana]
    session[:first_name_cana] = user_params[:first_name_cana]
    session[:birthday] = user_params[:birthday]
    @user = User.new

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
    if @user.save
      # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render '/signup/registration'
    end
  end

  private
 # 許可するキーを設定します
  def user_params
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
    )
  end

  def sns_credential_params
    params.require(:sns_credential).permit(
      :uid,
      :provider,
    )
  end

end
