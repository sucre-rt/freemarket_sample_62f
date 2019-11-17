class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         # omniauthに対応できるようにdeviseの機能を拡張

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_NAME_CANA = /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_cana, presence: true, format: { with: VALID_NAME_CANA }
  validates :first_name_cana, presence: true, format: { with: VALID_NAME_CANA }
  validates :birthday, presence: true
  validates :telphone, presence: true

  has_many :sns_credentials, dependent: :destroy
  has_many :payments
  has_many :products
  has_many :likes
  has_many :messages
  has_many :evaluations
  has_many :sns_credentials, dependent: :destroy
  has_one :adress, dependent: :destroy
  has_one :credit, dependent: :destroy
  
end