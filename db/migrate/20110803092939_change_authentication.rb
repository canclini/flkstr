class ChangeAuthentication < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
    remove_column :users, :encrypted_password
    remove_column :users, :password_salt
  end

  def down
    remove_column :users, :password_digest
  end
end
