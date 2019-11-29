class Card < ApplicationRecord

  # validates :card_id, presence: true
  # validates :customer_id, presence: true

  belongs_to :user

end
