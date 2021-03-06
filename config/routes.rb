Food::Application.routes.draw do
  match '/register/:activation_code' => "activations#new", :as => :register
  match '/activate/:id' => "activations#create", :as => :activate

  match 'logout' => 'user_sessions#destroy'
  match 'login'  => 'user_sessions#new'

  resources :user_sessions
  
  resources :password_resets

  resources :stores do
  	resources :dishes
  end

  resources :orders do
    member do
      put 'submit'
      put 'accept'
      put 'deliver'
    end
  	resources :items
  	member do
  	  get 'express'
  	  put 'start'
  	  put 'finish'
  	  put 'deliver'
  	end
  end

  resources :users do
  	get 'resend_activation', :on => :collection
  end

  # resources :roles

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "home#index"
end
