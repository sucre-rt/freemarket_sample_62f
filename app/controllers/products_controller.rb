class ProductsController < ApplicationController

  def sell
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to done_products_path
    else
      redirect_to controller: :products, action: :sell
    end

  end
 
  def done
  end
  
  def pay
    @product1 = Product.find(params[:id])
    @product2 = Product.find(params[:id]).images

    @postage = @product1.delivery.responsibility.include?("出品者負担") ? "送料込み" : "着払い"
    @havepoint = @product1.user.point
    @havepoint == 0 ? @havepoint = "ポイントがありません" : @havepoint
    @addressinfo = @product1.user.address

  end

private

  def product_params
    params.require(:product).permit(
      :name,
      :information,
      :price,
      :area,
      :status,
      :sending_days,
      :profit,
      :selling_status,
      :category_id,
      :delivery_id,
      :brand_id,
      images_attributes: [:id, :image]
    ).merge(user_id: current_user.id)
  end

end
