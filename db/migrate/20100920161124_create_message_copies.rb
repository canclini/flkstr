class CreateMessageCopies < ActiveRecord::Migration
  def self.up
    create_table :message_copies do |t|
      t.integer :recipient_id
      t.references :message
      t.boolean :read, :default => false
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :message_copies
  end
end
