class Item < ActiveRecord::Base
  belongs_to :dish
  belongs_to :order
  
  def full_price
  	price * quantity
  end
end
