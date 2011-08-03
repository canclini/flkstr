class ChangeAuthentication < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
    remove_column :users, :encrypted_password
    remove_column :users, :password_salt
    
    for user in User.find_all_by_password_digest(nil) do
      user.password = "wetkwemnasdkm123"
      user.save
    end
  end

  def down
    remove_column :users, :password_digest
  end
end
