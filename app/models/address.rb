class Address < ApplicationRecord
  
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_cana, presence: true
  validates :first_name_cana, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true

  belongs_to :user

  # def self.set_prefecture
  #   prefecture = [ 北海道: "北海道", 青森県: "青森県", 岩手県: "岩手県" ]
  # end

end
