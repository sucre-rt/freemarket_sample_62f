class Address < ApplicationRecord
  
  VALID_NAME_CANA = /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/
  VALID_POSTAL_CODE = /\A\d{3}[-]\d{4}\z/

  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_cana, presence: true, format: { with: VALID_NAME_CANA, message: 'は全角カタカナのみで入力してください' }
  validates :first_name_cana, presence: true, format: { with: VALID_NAME_CANA, message: 'は全角カタカナのみで入力してください' }
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE, message: 'はハイフンを含めた7桁の数字を入力してください' }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true

  belongs_to :user




  def self.set_prefecture
    prefecture = ["北海道", "青森県", "岩手県","宮城県", "秋田県",
      "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県",
      "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県",
      "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県",
      "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県",
      "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
      "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県",
      "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
  end
  
end
