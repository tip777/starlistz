class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def edit
    # @list = List.new
    @listitem = ListItem.all
    set_list
  end

  private
  def set_list
    @list = List.find(params[:id])
  end
end
