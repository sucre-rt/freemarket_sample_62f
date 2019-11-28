require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  
  describe 'GET #show' do
    before do
      @product_seller = FactoryBot.create(:image_seller).product
      @product_buyer = FactoryBot.create(:image_buyer).product
    end

    it "GET #showが呼ばれた時、正しいビューが表示される" do
      get :show, params: { id: @product_seller }
      expect(response).to render_template :show
    end
    
    it "@imagesに商品画像の情報が入っている" do
      get :show, params: { id: @product_seller }
      expect(assigns(:images)).to eq @product_seller.images
    end

    it "@sellerに出品者の情報が入っている" do
      get :show, params: { id: @product_seller }
      expect(assigns(:seller)).to eq @product_seller.user
    end

    it "@categoryに商品カテゴリーの情報が入っている" do
      get :show, params: { id: @product_seller }
      expect(assigns(:category)).to eq @product_seller.category
    end

    it "@deliveryに商品の送料の情報が入っている" do
      get :show, params: { id: @product_seller }
      expect(assigns(:delivery)).to eq @product_seller.delivery
    end

    it "商品の送料が出品者負担の場合、@postageが「送料込み」を返す" do
      get :show, params: { id: @product_seller }
      postage = "送料込み"
      expect(assigns(:postage)).to eq postage
    end

    it "商品の送料が購入者負担の場合、@postageが「着払い」を返す" do
      get :show, params: { id: @product_buyer }
      postage = "着払い"
      expect(assigns(:postage)).to eq postage
    end

    it "@back_productが、表示されているproduct.idより小さいidの商品を取得している" do
      get :show, params: { id: @product_seller }
      expect(assigns(:back_product).id).to be < @product_seller.id
    end

    it "@back_productが、削除されていない商品を取得している" do
      get :show, params: { id: @product_seller }
      expect(assigns(:back_product)).to_not eq be_empty
    end

    it "@next_productが、表示されているproduct.idより大きいidの商品を取得している" do
      get :show, params: { id: @product_seller }
      expect(assigns(:next_product).id).to be > @product_seller.id
    end

    it "@next_productが、削除されていない商品を取得している" do
      get :show, params: { id: @product_seller }
      expect(assigns(:next_product)).to_not eq be_empty
    end

    it "@seller_other_productsが期待した値を取得している" do
      get :show, params: { id: @product_seller }
      products = Product.where(user_id: @product_seller.user_id).order("id DESC").limit(6).where.not(id: @product_seller.id)
      expect(assigns(:seller_other_products)).to eq products
    end

    it "@category_other_productsが期待した値を取得している" do
      get :show, params: { id: @product_seller }
      products = Product.where(category_id: @product_seller.category.id).order("id DESC").limit(6).where.not(id: @product_seller.id)
      expect(assigns(:category_other_products)).to eq products
    end

  end

end

  # before do
  #   allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)
  # end

  # describe 'POST #buy' do
  # end


