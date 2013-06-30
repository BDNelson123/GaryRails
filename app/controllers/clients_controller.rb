class ClientsController < ApplicationController

  before_filter :authenticate_member!

  def new
   @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
	flash[:notice] = 'Client was successfully saved.'
        format.html { redirect_to(:controller => 'clients', :action => 'show', :id => @client.id) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def index
    @clients = self.pagination(
      Client, 
      params[:page], 
      params[:perPage], 
      params[:order], 
    )
  end

  def show
    @client = Client.find(params[:id])
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update_attributes(params[:client])
        respond_to do |format|
	  flash[:notice] = 'Client was successfully updated.'
          format.html { redirect_to(:controller => 'clients', :action => 'show', :id => @client.id) }
        end
    else
        respond_to do |format|
          format.html { render :action => "edit" }
        end
    end
  end

  def destroy
    respond_to do |format|
      Client.find(params[:id]).destroy
      flash[:notice] = "Client successfully deleted"
      format.html { redirect_to(:controller => 'clients', :action => 'index') }
    end
  end

end
