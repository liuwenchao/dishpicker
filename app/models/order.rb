class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :transactions, :class_name => "OrderTransaction"
  
  def purchase
    if self.purchased_at.blank?
      response = process_purchase
      transactions.create!(:action => "purchase", :response => response)
      if response.success?
        self.update_attribute(:purchased_at, Time.now) 
        self.update_attribute(:amount, response.params[:gross_amount])
      end
      return response.success?
    end 
    return false
  end
  
  def express_token=(token)
    write_attribute(:express_token, token)
    if !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
    end
  end
  
  def total_price
    return self.items.sum(:price)
  end
  
  private
  
  def process_purchase
    EXPRESS_GATEWAY.purchase(total_price, express_purchase_options)
  end
    
  def express_purchase_options
    {
      :ip => ip,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end
  
  def validate_card
    if express_token.blank? && !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
end
