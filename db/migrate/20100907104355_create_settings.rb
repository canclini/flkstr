class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.references :company
      t.string :twitter_access_token
      t.string :twitte_access_secret
      t.boolean :default_twitter_send, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
