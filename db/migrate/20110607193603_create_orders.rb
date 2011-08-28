class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.boolean :delivery
      t.string :payment
      t.string :notes
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
