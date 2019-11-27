class Category < ApplicationRecord
  validates :name, presence: true

  has_many :category_sizes
  has_many :sizes, through: :category_sizes
  has_many :products
  has_ancestry
end
