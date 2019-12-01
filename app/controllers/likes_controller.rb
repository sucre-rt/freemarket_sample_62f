class LikesController < ApplicationController
  before_action :set_product

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
        flash[:notice] = "いいねの削除に失敗しました"
        redirect_to product_path(@product.id)
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
    @id_name = "#like-link-#{@product.id}"
  end

end
