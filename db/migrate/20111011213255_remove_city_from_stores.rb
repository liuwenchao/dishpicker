class RemoveCityFromStores < ActiveRecord::Migration
  def up
    remove_column :stores, :city
    remove_column :stores, :state
    remove_column :stores, :country
    remove_column :stores, :zip
  end

  def down
    add_column :stores, :zip, :string
    add_column :stores, :country, :string
    add_column :stores, :state, :string
    add_column :stores, :city, :string
  end
end
