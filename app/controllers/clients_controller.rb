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
    @clients = Client.find(:all)
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
        format.html { render :action => "edit" }
    end
  end

  def destroy
  end

end
