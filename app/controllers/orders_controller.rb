class OrdersController < ApplicationController
	load_and_authorize_resource :order
	load_and_authorize_resource :item, :through => :order
	
  # GET /orders
  # GET /orders.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def express
		response = EXPRESS_GATEWAY.setup_purchase(@order.total_price,
			:ip                => request.remote_ip,
			:return_url        => edit_order_url,
			:cancel_return_url => root_url
		)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  # GET /orders/1/edit
  def edit
    @order.express_token = params[:token]
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order.ip = request.remote_ip
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        unless @order.purchased_at.blank?
          format.html { redirect_to(@order, :alert => "Order has been completed, please check the order history") }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
        if @order.purchase
          format.html { redirect_to(@order, :notice => 'Order was successfully placed.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit", :alert => 'Error happened, please try again.' }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /orders/1/submit
  def submit
    @order.ip = request.remote_ip
    respond_to do |format|
      if @order.status.nil?
        @order.status = 'submitted'
        @order.save
        format.html { redirect_to(@order, :alert => "Order has been submitted") }
      else
        format.html { render :action => "show" }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
