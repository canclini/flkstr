# -*- encoding : utf-8 -*-
class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :user
      t.references :notifiable, :polymorphic => true
      t.string :schedule, :default => 'weekly' # weekly, immediate, daily
      t.datetime :delivered_at
      t.string :status, :default => 'new' # new, processing, failed, delivered
      t.timestamps
    end    
    add_column :users, :notify, :string, :default => 'weekly'
    add_column :users, :notifiers_mask, :integer, :default => 7
    
    for user in User.all
      user.update_attributes(:notify => 'weekly')
      user.update_attributes(:notifiers_mask => 7)
    end
  end

  def self.down
    drop_table :notifications
    remove_column :users, :notify
    remove_column :users, :notifiers_mask
  end
end
