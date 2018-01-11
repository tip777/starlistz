class ListsController < ApplicationController
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
end
