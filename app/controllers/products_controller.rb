class ProductsController < ApplicationController

  before_action :set_category, only: [:sell, :create]

  def sell
    @product = Product.new
    @product_image = @product.images.build
    binding.pry
  end

  #ここからAjax通信用
  def category_children  
    @category_children = Category.find(params[:productcategory]).children 
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end
  #ここまでAjax通信用 


  def create
    @product = Product.new(product_params)
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

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @seller = @product.user
    @category = @product.category
    @delivery = @product.delivery
    @postage = @delivery.responsibility.include?("出品者負担") ? "送料込み" : "着払い"
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
      images_attributes: [:id, :product_id, :image]
    ).merge(user_id: current_user.id)
  end

  def set_category
    @category = Category.all.order("id ASC").limit(2)
  end

end
