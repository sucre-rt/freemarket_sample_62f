class AddressesController < ApplicationController

  # マイページ→発送元・届け先住所変更ページ用
  # 間違って作りました
  def edit
    @prefecture = Address.set_prefecture
    @user = current_user
    @birthday = @user.birthday.strftime('%Y/%m/%d')
    @address = Address.find_by(user_id: @user.id)
  end

  def update
    @address = Address.find_by(user_id: current_user.id)
    if @address.update(address_update_params)
      flash[:notice] = "変更しました。"
      redirect_to identification_addresses_path
    else 
      flash[:notice] = "変更に失敗しました。"
      redirect_to identification_addresses_path
    end
  end

  private

  def address_update_params
    params.require(:address).permit(
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
    ).merge(
      user_id: current_user.id
    )
  end
end
