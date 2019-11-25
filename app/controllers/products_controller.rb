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

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @seller = @product.user
    @category = @product.category
    @delivery = @product.delivery
    if @delivery.responsibility.include?("出品者負担")
      @postage = "送料込み"
    else
      @postage = "着払い"
    end
    @back_product = Product.where('id < ?', @product.id).first
    @next_product = Product.where('id > ?', @product.id).first
    @seller_other_products = Product.where(user_id: @seller.id).order("id DESC").limit(6).where.not(id: @product.id)
    @category_other_products = Product.where(category_id: @category.id).order("id DESC").limit(6).where.not(id: @product.id)
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
