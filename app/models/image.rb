class Image < ApplicationRecord
  validates :image, presence: true
  belongs_to :product

  mount_uploader :image, ImageUploader
end
