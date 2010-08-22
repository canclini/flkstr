class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :company
      t.boolean :main, :default => 'false'
      t.string :street
      t.string :city
      t.string :plz
      t.string :country
      t.float :lng # geolocation longitude
      t.float :lat # geolocation latitude
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
