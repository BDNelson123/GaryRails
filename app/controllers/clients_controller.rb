class ClientsController < ApplicationController

  before_filter :authenticate_member!

  def new
   @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to(:controller => 'clients', :action => 'view', :id => @client.id, :notice => 'Client was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def index
    @clients = Client.find(:all)
  end

  def view
  end

  def edit
  end

end
