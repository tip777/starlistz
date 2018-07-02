class ListsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :gon_current_user, only: [:show]

  def show
    @list = List.with_deleted.find_by(id: params[:id])
    if @list.nil?
      reject_page
    else
      #自分のプレイリスト、購入したプレイリスト以外は見れないように
      if current_user.nil?
        reject_page
      else
        #プレイリストが削除されてたら
        if @list.paranoia_destroyed?
          #購入済みのプレイリストのみ表示
          purchase_list = current_user.purchases.with_deleted.pluck(:list_id)
          exclude_list = purchase_list
          exclude_list.flatten!
          if !exclude_list.include?(params[:id].to_i)
              reject_page
          end
        else
          #自分が作成したもの、購入済みのプレイリストを表示
          my_list = current_user.lists.pluck(:id)
          purchase_list = current_user.purchases.pluck(:list_id)
          exclude_list = my_list.push(purchase_list)
          exclude_list.flatten!
          if !exclude_list.include?(params[:id].to_i)
              reject_page
          end
        end
      end
      
    end

  end

  def new
    @list = List.new
    taggings = set_list_genre
    @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
  end

  def edit
    set_lists
    
    if @list.nil? || @list.paranoia_destroyed?
      reject_page
    else
      taggings = set_list_genre
      @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
    end
    
  end

  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を作成しました"
    else
      render 'edit', alert: "「#{@list.title}」の作成に失敗しました"
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
     redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を更新しました"
    else
      render 'edit', alert: "「#{@list.title}」の更新に失敗しました"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を削除しました"
  end

  private
  
  def set_lists
    @list.tap { @list = nil }
    @list = List.with_deleted.find_by(id: params[:id])
  end

  def list_params
    params.require(:list).permit(:title, :description, :price, :image, :tag_list, tracks_attributes:[:id, :artist, :song, :description, :recommend, :row_order, :_destroy])
  end
end
