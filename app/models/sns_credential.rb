class SnsCredential < ApplicationRecord
  belongs_to :user

  validates :uid, presence: true, unipue: true
  validates :provider, presence: true, unipue: true
end
