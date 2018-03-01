class HomeController < ApplicationController
  before_action :set_list_genre, only: [:genre, :chart]
  def index
    @genre = ActsAsTaggableOn::Tag.where(taggings_count: 0) #メインジャンル
    @newlist = List.order('created_at') #新着のプレイリスト
  end

  def show
  end

  def genre
    # @q = ActsAsTaggableOn::Tag.ransack(params[:q])
    # @students = @q.result(distinct: true)
    #Listのタグだけ抽出
    taggings = ActsAsTaggableOn::Tagging.where(taggable_type: "List").pluck(:tag_id)
    list_tag = ActsAsTaggableOn::Tag.where(id: taggings)
    #ジャンル検索
    if params[:search].nil?
      @tag = nil
    else
      tags = list_tag.where("name like '%" + params[:search] + "%'")
    @tag = tags
    end
    
    #ジャンルトップ20
    
  end
  
  # def search
  #   @q = ActsAsTaggableOn::Tag.search(search_params)
  #   # @students = @q.result(distinct: true)
  #   @students = @q.result
  # end
  
  def chart
    #パラメータからリスト抽出
    # binding.pry
    if params[:genre] == "All" || params[:genre].nil? #ジャンルが空だったら
      if params[:sort] == "new" || params[:sort].nil? #sortが新着or空欄の場合
        @genre_list = List.order(:created_at)
      else  # 新着の場合
        @genre_list = List.eager_load(:list_favorites).group(:list_id).order('count(list_id) desc')
      end
    else
      genre = List.tagged_with(params[:genre]).pluck(:id)#ジャンルの対象のユーザーのIDの一覧取得
      if params[:sort] == "new" || params[:sort].nil? #sortが新着or空欄の場合
        @genre_list = List.where(id: genre).order(:created_at)
      else  # 新着の場合
        @genre_list = List.eager_load(:list_favorites).where(id: genre).group(:list_id).order('count(list_id) desc')
      end
    end
  end
  
  private
  
  def search_params
    params.require(:q).permit!
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

  # def set_genre
  #   # @base_genre = ListGenre.where(main: 1)
  #   # @other_genre = ListGenre.where(main: nil)
  #   # @tag = Hash.new{|h,k| h[k] = {} }
  #   # hash = {}
  #   # hash2 = {}
  #   # @tag = {"" => {"Allジャンル" => "allgenre"}}
  #   # @base_genre.each do |base_genre| #メインジャンル
  #   #   hash.store( base_genre.name,base_genre.name )
  #   # end
  #   # @other_genre.each do |other_genre| #その他
  #   #   hash2.store( other_genre.name, other_genre.name )
  #   # end
  #   # @tag["メインジャンル"] = hash
  #   # @tag["その他"] = hash2
  #
  #   mainno = ActsAsTaggableOn::Tag.where(taggings_count: 0)
  #   otherno = ActsAsTaggableOn::Tagging.where(context: "othergenres").pluck(:tag_id)
  #   @tag = Hash.new{|h,k| h[k] = {} }
  #   @tag["メインジャンル"] = ActsAsTaggableOn::Tag.where(id: mainno).pluck(:name)
  #   @tag["その他"] = ActsAsTaggableOn::Tag.where(id: otherno).pluck(:name)
  #
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
