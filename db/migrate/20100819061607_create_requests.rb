class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :name
      t.text :description
      t.references :company
      t.datetime :duedate
      t.integer :budget, :default => 0
      t.string :area_filter, :default => 'everywhere'
      t.string :distance, :default => 0 
      t.string :language, :default => 'DE'
      t.string :status, :default => 'open'
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
