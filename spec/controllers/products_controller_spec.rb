require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before do
    @image = FactoryBot.create(:image)
    @product = @image.product
  end

  describe 'GET #show' do
    
    it "GET #showが呼ばれた時、正しいビューが表示される" do
      get :show, params: { id: @product }
      expect(response).to render_template :show
    end



  end

  # before do
  #   allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)
  # end

  # describe 'POST #buy' do
  # end
end
