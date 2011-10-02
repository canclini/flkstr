# -*- encoding : utf-8 -*-
class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.references :company
      t.references :request
      t.integer :source_id
      t.string :status, :default => 'new'
      t.integer :weight, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :leads
  end
end
