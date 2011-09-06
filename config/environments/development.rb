Food::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # comment out this line:
  # config.action_view.debug_rjs             = true
  
  # Do not compress assets
  config.assets.compress = false
  
  # Expands the lines which load the assets
  config.assets.debug = true
  
  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # http://railscasts.com/episodes/146-paypal-express-checkout
  config.after_initialize do
  	ActiveMerchant::Billing::Base.mode = :test
		paypal_options = {
			:login => "seller_1308706446_biz_api1.gmail.com",
			:password => "KV96ZARFWZKUKT3U",
			:signature => "Ako-1MoW0VflDi7cHa8vB4E5vPTSAftghhu88KLGlNlWLliF4XEtnS5x"
		}
		::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
	end
	
	Paperclip.options[:command_path] = "/usr/bin/tes"
end

