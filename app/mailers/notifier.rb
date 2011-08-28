class Notifier < ActionMailer::Base
  default :from => "do-not-reply@dishpicker.com"
  default_url_options[:host] = "dev.dishpicker.com"
  default_url_options[:port] = "3000"
  
  def activation_instructions(user)
  	@user = user
  	@url = register_url(user.perishable_token)
  	mail(
  		:to => user.email,
  		:subject => "Activation Instructions")
	end
	
	def activation_confirmation(user)
		@user = user
		mail(
			:to => user.email,
			:subject => "Activation Complete")
	end
	
	def password_reset_instructions(user)
  	@user = user
  	@url = edit_password_reset_url(user.perishable_token)
  	mail(
  		:to => user.email,
  		:subject => "Password Reset Instructions")
	end
	
	def password_reset_confirmation(user)
		@user = user
		mail(
			:to => user.email,
			:subject => "Password Reset Complete")
	end
		
end
