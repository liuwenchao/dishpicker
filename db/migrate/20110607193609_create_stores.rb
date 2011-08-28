class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :tel
      t.text :hours
      t.integer :tables
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
