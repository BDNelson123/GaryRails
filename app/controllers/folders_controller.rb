class FoldersController < ApplicationController

  before_filter :authenticate_member!

  def new
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

  def index
    @folder = Folder.where(:client_id => params[:client_id])
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def edit
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

  def destroy
    @client = Client.find(params[:client_id])

    respond_to do |format|
      Folder.find(params[:id]).destroy
      flash[:notice] = "Folder successfully deleted"
      format.html { redirect_to(:controller => 'folders', :action => 'index', :member_id => @client.id) }
    end
  end
end
