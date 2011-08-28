class ActivationsController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
	
  def new
  	@user = User.find_using_perishable_token(params[:activation_code], 1.week)
  	if @user.active?
  		redirect_to root_url, :notice => 'Your activation link has expried!'
  	end
  end

  def create
  	@user = User.find(params[:id])
  	
  	if @user.active?
  		redirect_to root_url, :notice => 'Your activation link has expried!'
  	end

  	if @user.activate!(params)
  		@user.deliver_activation_confirmation!
  		redirect_to root_url, :notice => 'Your account has been verified!'
  	else
  		render :action => :new
  	end
  end

end
