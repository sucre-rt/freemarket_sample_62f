class SignupController < ApplicationController
  
  def registration
    @user = User.new
  end

  def sms_confirmation
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
    session[:telphone] = user_params[:telphone]
    @user = User.new
  end

  def address
  end

  def credit_card
  end

  def done
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
      :telphone
    )
  end

end
