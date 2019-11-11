class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email ,presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_cana, presence: true
  validates :first_name_cana, presence: true
  validates :birthday, presence: true
  validates :telphone, presence: true

  has_many :payments
  has_many :products
  has_many :likes
  has_many :messages
  has_many :evaluations
  has_many :sns_credentials, dependent: :destroy
  has_one :adress, dependent: :destroy
  has_one :credit, dependent: :destroy
end