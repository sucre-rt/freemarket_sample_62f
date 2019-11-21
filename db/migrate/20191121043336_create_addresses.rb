class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :family_name_cana, null: false
      t.string :first_name_cana, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.string :tel, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
