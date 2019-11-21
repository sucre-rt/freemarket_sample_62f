class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         # omniauthに対応できるようにdeviseの機能を拡張

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_NAME_CANA = /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/

  # validates :nickname, presence: true
  # validates :email, presence: true
  # validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :create
  # validates :family_name, presence: true
  # validates :first_name, presence: true
  # validates :family_name_cana, presence: true, format: { with: VALID_NAME_CANA }
  # validates :first_name_cana, presence: true, format: { with: VALID_NAME_CANA }
  # validates :birthday, presence: true
  # validates :telphone, presence: true

  has_many :sns_credentials, dependent: :destroy
  has_many :payments
  has_many :products
  has_many :likes
  has_many :messages
  has_many :evaluations
  has_many :sns_credentials, dependent: :destroy
  has_one :adress, dependent: :destroy
  has_one :credit, dependent: :destroy

  accepts_nested_attributes_for :sns_credentials
  accepts_nested_attributes_for :adress

  # Oauth認証

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?  # 該当するユーザーがいなければ新規ユーザーを作成
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
  end

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      # 同じメールアドレスでユーザーが登録されていた場合は、SNS情報のみ新しく作成
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      # メールアドレスが一致するユーザーがいなかった場合は、ユーザーもSNSも新規インスタンスを生成
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user, sns: sns }
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first   # 登録ずみのSNSデータがないか検索
    if snscredential.present?
      # すでにSNS情報を登録ずみなら、ユーザー情報とSNS情報をコントローラに返す
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      # SNS情報が登録されていなければSNS情報を生成し、それに伴うユーザー情報をコントローラに返す
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user, sns: sns }
  end
  
end