class ListsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :gon_current_user, only: [:show]

  def show
    @list = List.with_deleted.find_by(id: params[:id])
    @display_list = true
    if @list.nil?
      reject_page
    else
      if current_user != nil and @list.user == current_user
        redirect_to edit_list_path(@list) 
      else
        unless is_purchase?(current_user, @list)
          if @list.paranoia_destroyed?
            reject_page
          else
            @display_list = false
          end
        end
        
      end
    end
    
    @customer = find_or_create_stripe_customer(current_user)
    
  end

  def new
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @list = List.new
      taggings = set_list_genre
      @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
    end
    
  end

  def edit
    set_lists
    
    if @list.nil? || @list.paranoia_destroyed? || @list.user != current_user
      reject_page
    else
      taggings = set_list_genre
      @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
      if @tracks.nil?
        @tracks = @list.tracks.without_deleted.sort_by(&:row_order)
      end
      if is_release_list?(@list) != true
        flash.now[:alert] = "このプレイリストは非公開です。<br>
                        公開したい場合は　<a id='stripe_connect' href='#{stripe_url_edit(current_user)}'>Stripe接続</a>　をしてください。".html_safe
      end
    end
    
  end

  def create
    @list = current_user.lists.new(list_params)
    unless current_user.stripe_acct_id.nil?
      @list.status = "release"
    end
    if @list.save
      redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を作成しました"
    else
      @tracks = @list.tracks
      render 'edit', alert: "「#{@list.title}」の作成に失敗しました"
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
     redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を更新しました"
    else
      @tracks = @list.tracks.sort_by(&:row_order)
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
