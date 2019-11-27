class ProductsController < ApplicationController
  include MypageHelper

  def sell
    @product = Product.new
    @product_image = @product.images.build
  end

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
  
  def pay
    @product = Product.find(params[:id])
    @image = @product.images
    @postage = @product.delivery.responsibility.include?("出品者負担") ? "送料込み" : "着払い"
    @havepoint = @product.user.point == nil ? "ポイントがありません" : @product.user.point

    if current_user.card == nil
      
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      card = current_user.card
      customer = Payjp::Customer.retrieve(card.customer_id)
      @payjp_card = customer.cards.retrieve(card.card_id)
      @icon = card_icon(@payjp_card)
    end
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @seller = @product.user
    @category = @product.category
    @delivery = @product.delivery
    @postage = @delivery.responsibility.include?("出品者負担") ? "送料込み" : "着払い"
    @back_product = Product.where('id < ?', @product.id).order("id DESC").first
    @next_product = Product.where('id > ?', @product.id).first
    @seller_other_products = Product.where(user_id: @seller.id).order("id DESC").limit(6).where.not(id: @product.id)
    @category_other_products = Product.where(category_id: @category.id).order("id DESC").limit(6).where.not(id: @product.id)
  end

  def buy
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    card = current_user.card
    product = Product.find(params[:id])
    Payjp::Charge.create(
      amount:   product.price,
      customer: card.customer_id,
      currency: 'jpy'
    )
    product.update(selling_status: "売却済")
    redirect_to done_products_path
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
