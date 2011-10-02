# -*- encoding : utf-8 -*-
class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.integer :tags
      t.integer :leads
      t.integer :requests
      t.boolean :notify
      t.string :name
      t.string :cheddarcode
      t.timestamps      
    end
    Plan.create(:name => "ready", :cheddarcode => "READY", :tags => 3, :leads => 0, :requests => 0, :notify => false)
    Plan.create(:name => "connect", :cheddarcode => "CONNECT", :tags => 3, :leads => 3, :requests => 1, :notify => true)
    Plan.create(:name => "scale", :cheddarcode => "SCALE", :tags => 5, :leads => 999, :requests => 999, :notify => true)
    
  end

  def self.down
    drop_table :plans
  end
end
