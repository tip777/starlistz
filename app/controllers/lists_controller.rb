class ListsController < ApplicationController
  before_action :logged_in_user

  def new
    @list = List.new
  end

  def edit
    # @list = List.find(1)
    # @track = @list.tracks.order(:no)
    # binding.pry
    set_list
  end

  private
  def set_list
    @list = List.find(params[:id])
  end

  def track_params
    params.require(:list).permit(:artist, :song, :recommend, :row_order)
  end
end
