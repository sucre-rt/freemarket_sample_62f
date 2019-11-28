require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before do
    @product = FactoryBot.create(:product)
  end

  # factorybotの確認
  it "factory_botがproductを作成できている" do
    product = @product
    expect(product).to be_valid
  end

  # describe 'GET #show' do
    
  #   it "GET #showが呼ばれた時、正しいビューが表示される" do
  #     product = create(:product)
  #     get :show, params: { id: product }
  #     expect(response).to render_template :show
  #   end

  # end

  # before do
  #   allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)
  # end

  # describe 'POST #buy' do
  # end
end
