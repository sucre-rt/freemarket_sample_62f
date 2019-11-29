class MypageController < ApplicationController
  include MypageHelper

  def index
  end

  # ログアウトボタン表示ビュー
  def logout
  end

  # クレジットカード登録画面
  def card
    @card = current_user.card
    
    # payjpからカード情報を取り出す
    if @card != nil
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)  # ユーザー情報の取得
      @card_infomation = customer.cards.retrieve(@card.card_id) #ユーザーの情報からカードの情報を絞り込む

      @card_icon = card_icon(@card_infomation)  # mypageヘルパーのメソッドの呼び出し
    end
  end

end
