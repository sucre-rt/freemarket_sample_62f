class MypageController < ApplicationController
  def index
  end

  # ログアウトボタン表示ビュー
  def logout
  end

  # クレジットカード登録画面
  def card
    @card = Card.find_by(user_id: current_user.id)
  end

end
