# -*- encoding : utf-8 -*-
class AddTwitterToUpdates < ActiveRecord::Migration
  def self.up
    add_column :updates, :twitter, :boolean, :default => false    
  end

  def self.down
    remove_column :updates, :twitter
  end
end
