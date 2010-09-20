class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.references :company
      t.references :feed_item
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
