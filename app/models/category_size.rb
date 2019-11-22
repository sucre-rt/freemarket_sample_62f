class CategorySize < ApplicationRecord
  belongs_to :size
  belongs_to :category
end
