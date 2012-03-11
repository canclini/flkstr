class CompanyAttributesCleanup < ActiveRecord::Migration
  def up
    add_column :companies, :facebook, :string
    add_column :companies, :googleplus, :string
    remove_column :companies, :fax
  end

  def down
    remove_column :companies, :facebook
    remove_column :companies, :googleplus
    add_column :companies, :fax, :string
  end
end
