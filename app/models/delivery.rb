class Delivery < ApplicationRecord

  validates :responsibility, presence: true
  validates :way, presence: true

  has_many :products
  
end

