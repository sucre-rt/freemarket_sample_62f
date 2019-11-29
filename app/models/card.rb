class Card < ApplicationRecord

  validates :card_id, presence: true
  validates :customer_id, presence: true

  belongs_to :user

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

end
