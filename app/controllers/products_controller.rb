class ProductsController < ApplicationController

  def sell                                          #商品出品画面にいく
    @product = Product.new                          #productの中のカラムを作り、メソッドに入れる
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
