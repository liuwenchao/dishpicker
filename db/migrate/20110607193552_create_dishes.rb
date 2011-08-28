class CreateDishes < ActiveRecord::Migration
  def self.up
    create_table :dishes do |t|
      t.string :name
      t.string :picture
      t.text :detail
      t.string :note
      t.boolean :available
      t.integer :spicy
      t.boolean :veggie
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :dishes
  end
end
