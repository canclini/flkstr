class AddStatusToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :status, :string, :default => 'open'
    execute 'UPDATE requests SET status="open"'
  end
  def self.down
    remove_colum :requests, :status
  end
end
