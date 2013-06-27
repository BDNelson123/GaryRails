class FoldersController < ApplicationController

  before_filter :authenticate_member!

  def new
    @client = Client.find(params[:client_id])
    @folder = Folder.new
  end

  def create
    @folder = Folder.new(params[:folder])

    respond_to do |format|
      if @folder.save
        flash[:notice] = 'Folder was successfully created.'
        format.html { redirect_to(:controller => 'folders', :action => 'show', :id => @folder.id, :member_id => @folder.member_id) }
      else 
        format.html { render :action => "new" }
      end
    end
  end

  def index
    @client = Client.find(params[:client_id])
    @folder = Folder.where(:client_id => params[:client_id]).order("name asc")
    @count = Folder.where(:client_id => params[:client_id]).count
  end

  def edit
    @client = Client.find(params[:client_id])
    @folder = Folder.find(params[:id])
  end

  def update
    @folder = Folder.find(params[:id])

    if @folder.update_attributes(params[:folder])
      respond_to do |format|
        flash[:notice] = "Folder was successfully updated."
        format.html { redirect_to(:controller => 'folders', :action => 'show', :id => @folder.id, :member_id => @folder.member_id) }
      end
    else
      respond_to do |format|
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    @client = @folder.client_id

    respond_to do |format|
      @folder.destroy
      flash[:notice] = "Folder successfully deleted"
      format.html { redirect_to(:controller => 'folders', :action => 'index', :client_id => @client) }
    end
  end

end
