class HomeController < ApplicationController

  def index
    taggings = set_list_genre
    @genre = ActsAsTaggableOn::Tag.where(id: taggings).order("taggings_count").first(10) #トップ10　ジャンル
    @newlist = List.order('created_at').first(20) #新着のプレイリスト
  end

  def show
  end

  def genre
    taggings = set_list_genre
    
    #ジャンル検索
    if genre_params[:search].nil?
      @tag = nil
    else
      search_str = genre_params[:search].gsub(/[\s|　]+/, '')#文字列の中のスペースを削除
      # binding.pry
      @tag = ActsAsTaggableOn::Tag.where(id: taggings).where("name like '%" + search_str + "%'")
    end

    #ジャンルトップ20
    @tag_top = ActsAsTaggableOn::Tag.where(id: taggings).order("taggings_count").first(20)
  end

  def chart
    #セレクトボックス用のタグ
    taggings = set_list_genre
    @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
    @tag.unshift("All genre") #先頭に"All genre"追加

    #パラメータからリスト抽出
    if chart_params[:genre] == "All genre" || chart_params[:genre].nil? #ジャンルが空だったら
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        @genre_list = List.order(:created_at)
      else  # ランキングの場合
        @genre_list = List.joins(:list_favorites).group(:list_id).order('count(list_id) desc')
      end
    else
      genre = List.tagged_with(chart_params[:genre]).pluck(:id)#ジャンルの対象のリストのIDの一覧取得
      # binding.pry
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        # binding.pry
        @genre_list = List.where(id: genre).order(:created_at)
      else  # ランキングの場合
        @genre_list = List.joins(:list_favorites).where(id: genre).group(:list_id).order('count(list_id) desc')
      end
    end
  end

  private

  def genre_params
    params.permit(:search)
  end

  def chart_params
    params.permit(:genre, :sort)
  end

  #マルチ用
  # def chart
  #   #パラメータからリスト抽出
  #   array = Array.new
  #   # binding.pry
  #   if params[:genre].nil? #ジャンルが空だったら
  #     # if params[:sort] == "ranking" #ランキングの場合
  #     #   @genre_list = List.eager_load(:list_favorites).group(:list_id).order('count(list_id) desc')
  #     # else  # 新着の場合
  #     #   @genre_list = List.order(:created_at)
  #     # end
  #     if params[:sort] == "new" || params[:sort].nil? #sortが新着or空欄の場合
  #       @genre_list = List.order(:created_at)
  #     else  # 新着の場合
  #       @genre_list = List.eager_load(:list_favorites).group(:list_id).order('count(list_id) desc')
  #     end

  #   else

  #     params[:genre].each_with_index do |value, i| #ジャンルを配列に
  #       array.push(value)
  #     end
  #     genrelist = List.tagged_with(array).pluck(:id)#ジャンルの対象のユーザーのIDの一覧取得

  #     # if params[:sort] == "ranking" #ランキングの場合
  #     #   @genre_list = List.eager_load(:list_favorites).where(id: genrelist).group(:list_id).order('count(list_id) desc')
  #     # else  # 新着の場合
  #     #   @genre_list = List.where(id: genrelist).order(:created_at)
  #     # end
  #     if params[:sort] == "new" || params[:sort].nil? #sortが新着or空欄の場合
  #       @genre_list = List.where(id: genrelist).order(:created_at)
  #     else  # 新着の場合
  #       @genre_list = List.eager_load(:list_favorites).where(id: genrelist).group(:list_id).order('count(list_id) desc')
  #     end

  #   end
  # end

  # def name_check(name)
  #   ch = false
  #   if User.group(:name).where(name: name).count > 0
  #     ch = true
  #   end
  #   render nothing: true
  #   return ch
  # end

end
