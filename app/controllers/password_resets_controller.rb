class PasswordResetsController < ApplicationController
	before_filter :require_no_user
	before_filter :load_user_using_perishable_token, :only => [:edit, :update]
	
	def create
		@user = User.find_by_email(params[:email])
		
		if @user
			if @user.active
				@user.deliver_password_reset_instructions!
				redirect_to root_url, :notice => "Instructions to reset your passowrd have been emailed to you. Please check your email"
			else
				flash[:alert] = render_to_string(:partial => 'user_sessions/not_active.erb', :locals => { :user => @user })
				render :new
			end
		else
			flash[:alert] = "No user was found with that email address."
			render :new
		end
	end
	
	def update
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		
		if @user.save
			redirect_to root_url, :notice => "Password succressfully updated"
		else
			render :action => :edit
		end
	end
	
	private
	def load_user_using_perishable_token
		@user = User.find_using_perishable_token(params[:id])
		unless @user
			redirect_to root_url :notice => "We're sorry, but we could not locate your account. " +  
				"If you are having issues try copying and pasting the URL " +  
				"from your email into your browser or restarting the " +  
				"reset password process."
		end
		
		unless @user.active
			redirect_to root_url :notice => "We're sorry, but your email is not verified yet. " +  
				"If you did you receive email for activation, please check your spam folder. " +  
				"or re-send activation email."
		end
	end
	
end
