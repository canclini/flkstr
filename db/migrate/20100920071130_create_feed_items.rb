class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string :item_type
      t.integer :item_id
      t.timestamps
    end
  end

  def self.down
    drop_table :feed_items
  end
end
