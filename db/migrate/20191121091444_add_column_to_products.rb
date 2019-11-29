class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :category, null: false, foreign_key: true
    add_reference :products, :delivery, null: false, foreign_key: true
    add_reference :products, :brand, null: false, foreign_key: true
  end
end