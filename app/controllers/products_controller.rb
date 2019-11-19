class ProductsController < ApplicationController

  # def sell
  #   @product = Product.new
  #   @product.image.build
  # end

  def sell_test
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to done_products_path
    else
      redirect_to controller: :products, action: :sell_test
    end

  end

  def done
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
      images_attributes: [:id, :image]
    ).merge(user_id: 1)
  end

  def create                                        #
    @product = Product.new(product_params)
    @product.save
  end

private
  def product_params
    params.require(:product).permit(:name, :information, :price, :area, :status, :sending_days, :profit, :selling_status).merge(user_id: 1)
  end
end
