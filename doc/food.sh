rm food/ -rf
rails new food
cd food
# rails generate controller home index
# http://schema.org/Restaurant 
# http://schema.org/Person
# http://schema.org/Recipe
# http://schema.org/FoodEvent 

rails g scaffold user email:string name:string password:string 
rails g scaffold role name:string
rails g scaffold order delivery:boolean payment:string notes:string user:references
rails g scaffold store name:string address:string city:string state:string country:string zip:string tel:string hours:text tables:integer user:references
rails g scaffold dish name:string picture:string detail:text note:string available:boolean spicy:integer veggie:boolean price:integer
rails g scaffold order delivery:boolean payment:string notes:string user:references
rails g scaffold item price:integer status:string dish:references order:references

echo "add following into Rakefile"
echo "class Rails::Application"
echo "  include Rake::DSL if defined?(Rake::DSL)"
echo "end"
echo ""

#rake db:migrate
#rails server

echo "install authlogic
install cancan from http://railscasts.com/episodes/192-authorization-with-cancan
http://www.claytonlz.com/index.php/2009/07/authlogic-account-activation-tutorial/
http://www.binarylogic.com/2008/11/16/tutorial-reset-passwords-with-authlogic/
https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale/
https://github.com/iain/http_accept_language
"
