class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = List.new
  end

  def edit
    set_lists
  end
  
  def create
    @list = List.new(track_params)
    if @list.save
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  def update
    @list = List.find(params[:id])
    if @list.update(track_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  def destroy
    @list.destroy
    redirect_to current_user
  end
  
  private
  def set_lists
    @list.tap { @list = nil }
    @list = List.find(params[:id])
  end

  def track_params
    params.require(:list).permit(:title, :description, :price, tracks_attributes:[:id, :artist, :song, :recommend, :row_order, :_destroy])
  end
end
