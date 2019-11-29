class ChangeDataPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :encrypted_password, :string, null: true
  end
end
