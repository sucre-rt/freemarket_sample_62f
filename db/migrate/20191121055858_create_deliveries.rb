class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string :responsibility, null: false
      t.string :way, null: false
      t.timestamps
    end
  end
end
