class Product < ApplicationRecord
  validates :name, presence: true, length: {in: 1..40}
  validates :information, presence: true, length: {in: 1..1000}
  validates :price, presence: true, inclusion: { in: (300..9999999)}
  validates :area, presence: true
  validates :status, presence: true
  validates :sending_days, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true, numericality: { greater_than_or_equal_to: 152 }
  validates :delivery_id, presence: true, numericality: { greater_than_or_equal_to: 3 }

  has_one :evaluation
  has_one :payment
  has_many :likes, dependent: :destroy
  has_many :transactions
  has_many :messages, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  belongs_to :category
  belongs_to :delivery
  belongs_to :brand

  # 商品名のあいまい検索
  scope :product_like, -> (keyword) { where('name LIKE ? or information LIKE ?', "%#{keyword}%", "%#{keyword}%") if keyword.present? }

end