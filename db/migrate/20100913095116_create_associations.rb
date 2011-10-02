# -*- encoding : utf-8 -*-
class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
      t.references :company, :null => :false
      t.integer :associate_id, :null => :false
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :associations
  end
end
