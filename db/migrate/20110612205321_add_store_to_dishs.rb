class AddStoreToDishs < ActiveRecord::Migration
  def self.up
  	add_column :dishes, :store_id, :integer
  end

  def self.down
  	remove_column :dishes, :store_id, :integer
  end
end
