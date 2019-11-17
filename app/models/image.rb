class Image < ApplicationRecord
  validates :image, presence: true
  belongs_to :product
end
