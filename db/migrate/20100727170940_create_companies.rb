class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :permalink # replaces the standard id in the URL
      t.string :name
      t.text :teaser
      t.text :history
      t.string :phone
      t.string :fax
      t.string :email
      t.string :twitter
      t.string :website
      t.integer :staff
      t.references :sector
      t.integer :requests_count, :default => 0, :null => false
      t.integer :leads_count, :default => 0, :null => false

      #paperclip stuff for the logo
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
