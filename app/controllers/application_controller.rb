include HttpAcceptLanguage

class ApplicationController < ActionController::Base
  protect_from_forgery
  #check_authorization
  helper_method :current_user_session, :current_user, :current_order
  before_filter :set_locale
	
	rescue_from CanCan::AccessDenied do |exception|
		Rails.logger.debug "Access Denied: #{exception.message}"
		redirect_to login_url, :alert => exception.message
	end
	
	def set_locale
		I18n.locale = request.compatible_language_from I18n.available_locales
	end
	
	def current_order
    if session[:order_id]
      @current_order ||= Order.find(session[:order_id])
      session[:order_id] = nil if @current_order.user_id != current_user.id
      session[:order_id] = nil if @current_order.purchased_at
    end
    if session[:order_id].nil?
      @current_order = Order.create!(:user_id => current_user.id)
      session[:order_id] = @current_order.id
    end
    @current_order
  end

	private
	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.user
	end
	
	def require_user
		unless current_user
			store_location
			flash[:notice] = "You must be logged in to access this page"
			redirect_to new_user_session_url
			return false
		end
	end

	def require_no_user
		if current_user
			store_location
			flash[:notice] = "You must be logged out to access this page"
			redirect_to account_url
			return false
		end
	end
	
	def store_location
		session[:return_to] = request.request_uri
	end
	
	def redirect_back_or_default(default)
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end    	
end
