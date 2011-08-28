class AddIpToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :ip, :string
  end

  def self.down
    remove_column :orders, :ip
  end
end
