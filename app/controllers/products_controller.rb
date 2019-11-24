class ProductsController < ApplicationController

  def sell
    @product = Product.new
    @product_image = @product.images.build
  end

  def create
    @product = Product.new(product_params)
    binding.pry
    if @product.save
      params[:images][":image"].each do |a|
        @product_image = @product.images.create!(image: a, product_id: @product.id)
      end
      redirect_to done_products_path
    else
      redirect_to controller: :products, action: :sell
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
      :category_id,
      :delivery_id,
      :brand_id,
      images_attributes: [:id, :product_id, :image]
    ).merge(user_id: current_user.id)
  end

end
