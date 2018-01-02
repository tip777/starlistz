class HomeController < ApplicationController
  before_action :set_genre, only: [:genre, :chart]
  def index
    mainno = ActsAsTaggableOn::Tagging.where(context: "maingenres").pluck(:tag_id)
    @genre = ActsAsTaggableOn::Tag.where(id: mainno)
    @newlist = List.order('created_at')
  end

  def show
  end

  def genre
  end

  # def chart
  #   #パラメータからリスト抽出
  #   array = Array.new
  #
  #   if params[:genre][0] == "all" #ジャンルが空だったら
  #     if params[:sort] == "ranking" #ランキングの場合
  #       @genre_list = List.eager_load(:list_favorites).group(:list_id).order('count(list_id) desc')
  #     else  # 新着の場合
  #       @genre_list = List.order(:created_at)
  #     end
  #
  #   else
  #
  #     params[:genre].each_with_index do |value, i| #ジャンルを配列に
  #       array.push(value)
  #     end
  #     genrelist = List.tagged_with(array).pluck(:id)#ジャンルの対象のユーザーのIDの一覧取得
  #
  #     if params[:sort] == "ranking" #ランキングの場合
  #       @genre_list = List.eager_load(:list_favorites).where(id: genrelist).group(:list_id).order('count(list_id) desc')
  #     else  # 新着の場合
  #       @genre_list = List.where(id: genrelist).order(:created_at)
  #     end
  #
  #   end
  # end

  def set_genre
    # @base_genre = ListGenre.where(main: 1)
    # @other_genre = ListGenre.where(main: nil)
    # @tag = Hash.new{|h,k| h[k] = {} }
    # hash = {}
    # hash2 = {}
    # @tag = {"" => {"Allジャンル" => "allgenre"}}
    # @base_genre.each do |base_genre| #メインジャンル
    #   hash.store( base_genre.name,base_genre.name )
    # end
    # @other_genre.each do |other_genre| #その他
    #   hash2.store( other_genre.name, other_genre.name )
    # end
    # @tag["メインジャンル"] = hash
    # @tag["その他"] = hash2

    mainno = ActsAsTaggableOn::Tagging.where(context: "maingenres").pluck(:tag_id)
    otherno = ActsAsTaggableOn::Tagging.where(context: "othergenres").pluck(:tag_id)
    @tag = Hash.new{|h,k| h[k] = {} }
    @tag["メインジャンル"] = ActsAsTaggableOn::Tag.where(id: mainno).pluck(:name)
    @tag["その他"] = ActsAsTaggableOn::Tag.where(id: otherno).pluck(:name)

  end

  # def name_check(name)
  #   ch = false
  #   if User.group(:name).where(name: name).count > 0
  #     ch = true
  #   end
  #   render nothing: true
  #   return ch
  # end

end
