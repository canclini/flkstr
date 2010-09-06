class AddTwitterToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :access_token, :string
    add_column :companies, :access_secret, :string
    
  end

  def self.down
  end
end
