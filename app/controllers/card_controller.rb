class CardController < ApplicationController
  include CardHelper

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_mypage_path unless card.blank?
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    unless params['payjp_token'].blank?

      # payjp上でユーザーを作成。payjpにカード情報を登録
      customer = Payjp::Customer.create(
        card:  params['payjp_token']
      )

      # payjpから送られてくる情報を利用してcardテーブルのインスタンスを作成
      @card = Card.new(
        user_id:      current_user.id,
        customer_id:  customer.id,
        card_id:      customer.default_card
      )

      if @card.save
        redirect_to card_mypage_path
      else
        redirect_to card_new_path
      end

    else
      redirect_to card_new_path
    end

  end

  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card != nil
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete   # payjp側の情報を削除
      card.destroy       # cardテーブルの情報を削除
      redirect_to card_mypage_path
    else
      redirect_to card_mypage_path
    end
  end
  
end
