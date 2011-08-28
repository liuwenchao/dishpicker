class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :price
      t.string :status
      t.references :dish
      t.references :order

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
