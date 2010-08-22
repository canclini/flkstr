class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.integer :tags
      t.integer :leads
      t.integer :requests
      t.boolean :notify
      t.string :name
      t.timestamps      
    end
    Plan.create(:name => "ready", :tags => 3, :leads => 0, :requests => 0, :notify => false)
    Plan.create(:name => "connect", :tags => 3, :leads => 3, :requests => 1, :notify => true)
    Plan.create(:name => "scale", :tags => 5, :leads => 999, :requests => 999, :notify => true)
    
  end

  def self.down
    drop_table :plans
  end
end
