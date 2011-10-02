# -*- encoding : utf-8 -*-
class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.references :company
      t.string :twitter_access_token
      t.string :twitter_access_secret
      t.boolean :default_twitter_send, :default => false
      t.timestamps
    end
    
    for company in Company.all
      company.create_setting
    end
    
  end

  def self.down
    drop_table :settings
  end
end
