class ChangePasswordToUsers < ActiveRecord::Migration[5.0]

  def up
    change_column :users, :encrypted_password, :string, null: false, default: ""
  end

  def down
    change_column :users, :encrypted_password, :string, null: true
  end

end
