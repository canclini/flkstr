# -*- encoding : utf-8 -*-
class AddAuthTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :auth_token, :string
    remove_column :users, :remember_token
    remove_column :users, :remember_created_at
    for user in User.all do
      user.generate_token(:auth_token)
      user.save
    end
  end
  
  def self.down
    remove_column :users, :auth_token
  end
  
  
end
