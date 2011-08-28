class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
		c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
	end
	has_many :assignments
	has_many :roles, :through => :assignments
	
	#activation for authlogic
	attr_accessible :login, :email, :name, :password, :password_confirmation
	
	def role?(role)
		self.role == role.to_s
	end
	
	# we need to make sure that either a password or openid gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank?# && self.openid_identifier.blank?
  end
  
  # now let's define a couple of methods in the user model. The first
  # will take care of setting any data that you want to happen at signup
  # (aka before activation)
  def signup!(params)
    self.name = params[:user][:name]
    self.email = params[:user][:email]
    self.password = '_'
    self.password_confirmation = '_'
    save_without_session_maintenance
  end
  
	def active?
		active
	end
	
	def activate!(params)
		self.active = true
		self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    #self.openid_identifier = params[:user][:openid_identifier]
		save
	end
	
	def deliver_activation_instructions!
		reset_perishable_token!
		Notifier.activation_instructions(self).deliver
	end
	
	def deliver_activation_confirmation!
		reset_perishable_token!
		Notifier.activation_confirmation(self).deliver
	end
	
	def deliver_password_reset_instructions!
		reset_perishable_token!
		Notifier.password_reset_instructions(self).deliver
	end
	
	def deliver_password_reset_confirmation!
		reset_perishable_token!
		Notifier.password_reset_confirmation(self).deliver
	end
	
	
	#TODO step8
	
	def to_s
		name
	end
end
