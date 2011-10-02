# -*- encoding : utf-8 -*-
class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.references :company
      t.references :plan
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
