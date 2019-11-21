class Size < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true
  

  has_many :category_sizes
  has_many :categories, through: :category_sizes
end
