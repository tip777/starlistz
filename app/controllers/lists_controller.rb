class ListsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :gon_current_user, only: [:show]

  def show
    @list = List.with_deleted.find_by(id: params[:id])
    @display_list = true
    @user = @list.user
    if @list.nil?
      reject_page
    else
      if current_user != nil and @list.user == current_user
        @display_list = true
        if is_release_list?(@list) != true
          flash.now[:alert] = "このプレイリストは非公開です。<br>
                          <a id='listRelease' href='#{list_release_path(current_user)}'>プレイリストを公開する</a>".html_safe
        end
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
      #アカウント情報が登録済みかどうか
      if PersonInfo.where(user_id: current_user.id).empty?
        redirect_to person_info_path(current_user, ref: "list_add")
        
      else
        @list = List.new
        
      end
      
    end
    
  end

  def edit
    reject_pageh if current_user.nil?

    @list = current_user.lists.find_by(id: params[:id])
    
    if @list.nil? || @list.paranoia_destroyed?
      reject_page
      
    else
      if @tracks.nil?
        @tracks = @list.tracks.without_deleted.sort_by(&:row_order)
      end
      
    end

  end

  def create
    reject_pageh if current_user.nil?

    @list = current_user.lists.new(list_params)
    is_stripe = false #Stripe連携済みかのフラグ
    
    unless current_user.stripe_acct_id.nil? #Stripe連携済だったら
      @list.status = "release"
      is_stripe = true
    end
    
    if @list.save
      if is_stripe
        redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を作成しました"
      else
        redirect_to users_payment_path(current_user)
      end
      
    else
      @tracks = @list.tracks
      render 'edit'
    end

  end

  def update
    reject_pageh if current_user.nil?

    @list = current_user.lists.find_by(id: params[:id])
    
    if !@list.nil?
      if @list.update(list_params)
        # 削除済みのトラックを物理削除する
        mylist_tracks = @list.tracks
        mylist_tracks.each_with_index do |track, i|
          unless mylist_tracks[i].deleted_at.nil?
            mylist_tracks[i].really_destroy!
          end
        end
        redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を更新しました"
      else
        @tracks = @list.tracks.sort_by(&:row_order)
        render 'edit'
      end
    else
      redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」の更新に失敗しました"
    end

  end

  def destroy
    reject_pageh if current_user.nil?

    @list = current_user.lists.find_by(id: params[:id])
    
    if !@list.nil?
      @list.destroy
      redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」を削除しました"
    else
      redirect_to users_playlist_path(current_user), notice: "「#{trun_str(@list.title, 18)}」の削除に失敗しました"
    end

  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :price, :tag_list, tracks_attributes:[:id, :artist, :song, :description, :recommend, :row_order, :_destroy])
  end
end
