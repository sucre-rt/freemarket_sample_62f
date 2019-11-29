class Delivery < ApplicationRecord

  validates :responsibility, presence: true

  has_many :products
  has_ancestry
end

