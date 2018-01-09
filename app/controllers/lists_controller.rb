class ListsController < ApplicationController
  def new
    @list = List.new
  end
  
  def edit
    # @list = List.new
  end
end
