class AddProcessingToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :logo_processing, :boolean, :default => false
  end
 
  def self.down
    remove_column :companies, :logo_processing
  end
end
