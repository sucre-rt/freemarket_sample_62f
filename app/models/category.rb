class Category < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true

  has_many :category_sizes
  has_many :sizes, through: :category_sizes
end
