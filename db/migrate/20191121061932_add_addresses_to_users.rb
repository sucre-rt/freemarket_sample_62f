class AddAddressesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :building, :string
  end
end
