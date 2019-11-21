class Product < ApplicationRecord
  validates :name, presence: true, length: {in: 1..40}
  validates :information, presence: true, length: {in: 1..1000}
  validates :price, presence: true, inclusion: { in: (300..9999999)}
  validates :area, presence: true
  validates :status, presence: true
  validates :sending_days, presence: true
  validates :user, presence: true

  has_one :evaluation
  has_one :payment
  has_many :likes, dependent: :destroy
  has_many :transactions
  has_many :messages
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :delivery
  belongs_to :brand
end