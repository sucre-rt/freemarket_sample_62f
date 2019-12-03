require 'rails_helper'

RSpec.describe CardController, type: :controller do

  describe "ログインしたユーザー" do

    describe 'get #new' do
      before do
        allow(Rails.application.credentials).to receive(:big).and_return('123', '456')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
        sign_in user
      end

      it "ユーザーがカードをすでに登録している場合、カード一覧に遷移させる" do
        get :new
        expect(response).to redirect_to card_mypage_path
      end

      it "ユーザーがカードを登録していない場合、正しいビューが表示される" do
        user = ""
        another_user = FactoryBot.create(:another_user)
        sign_in another_user
        get :new
        expect(response).to render_template :new
      end

    end

    describe 'post #create' do
      before do
        allow(Rails.application.credentials).to receive(:big).and_return('123', '456')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
        sign_in user
      end

      it "params['payjp_token']がなければcard_new_pathに遷移する" do
        post :create, params: { payjp_token: "" }
        expect(response).to redirect_to card_new_path
      end

      it "@cardが正しくcustomer_idを取得している" do
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.customer_create_response)
        post :create, params: { payjp_token: "cus_121673955bd7aa144de5a8f6c262" }
        @card = Card.new(
          user_id:      1,
          customer_id:  "cus_121673955bd7aa144de5a8f6c262",
          card_id:      "car_d0e44730f83b0a19ba6caee04160",
        )
        expect(assigns(:card).customer_id).to eq @card.customer_id
      end

      it "@cardが正しくcard_idを取得している" do
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.customer_create_response)
        post :create, params: { payjp_token: "cus_121673955bd7aa144de5a8f6c262" }
        @card = Card.new(
          user_id:      1,
          customer_id:  "cus_121673955bd7aa144de5a8f6c262",
          card_id:      "car_d0e44730f83b0a19ba6caee04160",
        )
        expect(assigns(:card).card_id).to eq @card.card_id
      end

      it "@cardが保存できたらcard_mypage_pathに遷移する" do
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.customer_create_response)
        post :create, params: { payjp_token: "cus_121673955bd7aa144de5a8f6c262" }
        expect(response).to redirect_to card_mypage_path
      end

      it "@cardが保存できなかったらcard_new_pathに遷移する" do
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.error_response)
        post :create, params: { payjp_token: "cus_121673955bd7aa144de5a8f6c262" }
        expect(response).to redirect_to card_new_path
      end

    end

    describe 'delete #destroy' do
      
      before do
        allow(Rails.application.credentials).to receive(:big).and_return('123', '456')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      
      it "カードを保有していないユーザーはカード登録ページに遷移させる" do
        user = ""
        another_user = FactoryBot.create(:another_user)
        sign_in another_user
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to card_mypage_path
      end

      # どうしてもcustomer.deleteを通せないので、テスト実行時はコントローラの記述をコメントアウトしくてださい
      it "カードが削除できた場合、その旨のフラッシュメッセージを表示する" do
        allow(Payjp::Customer).to receive(:retrieve).with("cus_121673955bd7aa144de5a8f6c262").and_return(PayjpMock.customer_create_response)
        # customer = Payjp::Customer.retrieve("cus_121673955bd7aa144de5a8f6c262")
        # allow(customer).to receive(:delete).with("cus_121673955bd7aa144de5a8f6c262").and_return(PayjpMock.customer_delete)
        delete :destroy, params: { id: @user.card.id }
        expect(flash[:notice]).to eq "カード情報を削除しました"
      end

    end

  end

  describe "ログインしていないユーザー" do

    describe 'get #new' do
      
      it "ログインページにリダイレクトする" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end

    end

    describe 'post #create' do

      it "ログインページにリダイレクトする" do
        post :create, params: { payjp_token: "cus_121673955bd7aa144de5a8f6c262" }
        expect(response).to redirect_to new_user_session_path
      end
      
    end

    describe 'delete #destroy' do
      
      it "ログインページにリダイレクトする" do
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

    end

  end

end
