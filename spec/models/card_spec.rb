require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#create' do

    # cardモデルのバリデーションテスト
    it "card_id・customer_id・user_idが全て入っていれば登録できる" do
      card = Card.new(
        card_id:      "car_0000000000000000000000000000",
        customer_id:  "cus_0000000000000000000000000000",
        user_id:      @user.id
      )
      expect(card).to be_valid
    end

    it "card_idがなければ登録できない" do
      card = Card.new(
        card_id:      "",
        customer_id:  "cus_0000000000000000000000000000",
        user_id:      @user.id
      )
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end

    it "customer_idがなければ登録できない" do
      card = Card.new(
        card_id:      "car_0000000000000000000000000000",
        customer_id:  "",
        user_id:      @user.id
      )
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end

    it "user_idがなければ登録できない" do
      card = Card.new(
        card_id:      "car_0000000000000000000000000000",
        customer_id:  "cus_0000000000000000000000000000",
        user_id:      ""
      )
      card.valid?
      expect(card.errors[:user]).to include("must exist")
    end


  end

end
