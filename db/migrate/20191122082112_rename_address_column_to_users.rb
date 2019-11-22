class RenameAddressColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :address, :user_address
  end
end
