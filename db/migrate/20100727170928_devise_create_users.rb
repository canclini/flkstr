class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email, :unique => true
      t.string    :firstname
      t.string    :lastname
      t.string    :language
      t.string    :function
      t.references :company
      t.string    :phone
      t.string    :xing
      t.string    :fb
      t.string    :twitter
      t.string    :skype
      t.boolean   :admin,               :default => false
      t.date      :since
      t.text      :details


      t.timestamps
    end

    add_index :users, :email,                :unique => true
  end

  def self.down
    drop_table :users
  end
end
