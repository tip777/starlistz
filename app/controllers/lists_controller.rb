class ListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
    set_list_genre
  end

  def edit
    set_lists
    set_list_genre
  end

  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    binding.pry
    @list = List.find(params[:id])
    @list.destroy
    redirect_to current_user
  end

  private
  def set_lists
    @list.tap { @list = nil }
    @list = List.find(params[:id])
  end

  def set_lsit_genre
    # binding.pry
    # listGenre = List.all_tag
    # mainGenre = ActsAsTaggableOn::Tag.where(taggings_count: 0)
    # @genre = listGenre + mainGenre
    # binding.pry
    @genre = ActsAsTaggableOn::Tag.all
  end

  def list_params
    params.require(:list).permit(:title, :description, :price, :image, othergenre_list: [], tracks_attributes:[:id, :artist, :song, :recommend, :row_order, :_destroy])
  end
end
