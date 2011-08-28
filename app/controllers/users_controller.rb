class UsersController < ApplicationController
	#resource will only be loaded into an instance variable if it hasn't been already.
	before_filter :find_current_user, :only => :edit
	load_and_authorize_resource
	
  # GET /users
  # GET /users.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.xml
  def create
    respond_to do |format|
      if @user.signup!(params)
      	@user.deliver_activation_instructions!
        format.html { redirect_to(root_url, :notice => 'Registeration was successful. Please check your e-mail for your account activation instructions!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def resend_activation
  	if params[:email]
  		@user = User.find_by_email params[:email]
  		if @user && !@user.active?
  			@user.deliver_activation_instructions!
  			redirect_to root_url, :notice => "Please check your e-mail for your account activation instructions!"
  		end
  	end
  end
  
  private
	def find_current_user
		@user = current_user
	end
end
