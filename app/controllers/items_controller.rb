class ItemsController < ApplicationController
	#resource will only be loaded into an instance variable if it hasn't been already.
	before_filter :find_current_order, :only => [:new, :create]
	load_and_authorize_resource :order
	load_and_authorize_resource :item, :through => :order	

  # GET /items
  # GET /items.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # POST /items
  # POST /items.xml
  def create
  	@dish = Dish.find(params[:dish_id])
  	@item = Item.create!(:order => current_order, :dish => @dish, :quantity => 1, :price => @dish.price)
    respond_to do |format|
      if @item.save
        format.html { redirect_to(order_items_path, :notice => 'Item was successfully added into the cart.') }
      else
        format.html { redirect_to(@dish, :notice => 'Item was not added into the cart.') }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(order_items_path) }
    end
  end
  
	private
	def find_current_order
		@order = current_order
	end

end
