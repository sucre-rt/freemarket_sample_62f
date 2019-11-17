class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :information, null: false
      t.integer :price, null: false
      t.string :area, null: false
      t.string :status, null: false
      t.string :sending_days, null: false
      t.integer :profit, null: false
      t.string :selling_status, null: false
      t.references :user, null: false, foreign_key: true
    end
  end
end
