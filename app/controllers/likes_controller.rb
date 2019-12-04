class LikesController < ApplicationController
  before_action :set_product
  before_action :move_to_login

  def create
    if current_user != nil
      @like = current_user.likes.new(product_id: @product.id)
      if @like.save
        @like_count = @product.likes.count
      else
        flash[:notice] = "いいねに失敗しました"
        redirect_to product_path(@product.id)
      end
    end
  end

  def destroy
    if current_user != nil
      @like = current_user.likes.find_by(product_id: @product.id)
      if @like.destroy
        @like_count = @product.likes.count
      else
        flash[:alert] = "いいねの削除に失敗しました"
        redirect_to product_path(@product.id)
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
    @id_name = "#like-link-#{@product.id}"
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
