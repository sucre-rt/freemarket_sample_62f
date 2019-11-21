class AddressesController < ApplicationController

  # マイページ→本人情報ページ
  def edit
    @prefecture = ""
    @user = current_user
    @birthday = @user.birthday.strftime('%Y/%m/%d')
    @address = Adress.find_by(user_id: @user.id)
  end

  def update
    @address = Adress.find_by(user_id: current_user.id)
    @address.update(address_update_params)
  end

  private

  def address_update_params
    params.require(:adress).permit(
      :family_name,
      :first_name,
      :family_name_cana,
      :first_name_cana,
      :postal_code,
      :prefenture,
      :city,
      :address,
      :building,
      :tel
    ).merge(
      user_id: current_user.id
    )
  end
end
