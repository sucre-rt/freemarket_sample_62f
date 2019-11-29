class Product < ApplicationRecord
  validates :name, presence: true, length: {in: 1..40}
  validates :information, presence: true, length: {in: 1..1000}
  validates :price, presence: true, inclusion: { in: (300..9999999)}
  validates :area, presence: true
  validates :status, presence: true
  validates :sending_days, presence: true
  validates :user_id, presence: true

  has_one :evaluation
  has_one :payment
  has_many :likes
  has_many :transactions
  has_many :messages
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  belongs_to :category
  belongs_to :delivery
  belongs_to :brand

  # 商品名のあいまい検索
  scope :product_name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }

end