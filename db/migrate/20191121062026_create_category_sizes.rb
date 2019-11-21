class CreateCategorySizes < ActiveRecord::Migration[5.0]
  def change
    create_table :category_sizes do |t|
      t.references :size, null: false, forgin_key: true
      t.references :category, null: false, forgin_key: true
      t.timestamps
    end
  end
end
