class CreatePriceSuggestions < ActiveRecord::Migration
  def self.up
    create_table :price_suggestions do |t|
      t.string :price
      t.string :plan

      t.timestamps
    end
  end

  def self.down
    drop_table :price_suggestions
  end
end
