class Adress < ApplicationRecord
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_cana, presence: true
  validates :first_name_cana, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :user, presence: true

  belongs_to :user, optional: true

end