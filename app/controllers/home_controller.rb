class HomeController < ApplicationController
  before_action :gon_current_user, only: [:index, :show, :chart, :search]

  def index
    if !current_user.nil?
      # 初めてのログイン、オンボーディング対応後にログインした場合はオンボーディングへ
      if current_user.sign_in_count == 1 || current_user.last_sign_in_at < Date.new(2019, 5 , 3) 
        current_user.update(
          last_sign_in_at: Time.current,
          sign_in_count: current_user.sign_in_count + 1
        )
        redirect_to welcome_path
      end
      
      taggings = set_list_genre
      @genre = ActsAsTaggableOn::Tag.where(id: taggings).order("taggings_count").first(10) #トップ10　ジャンル
      @newlist = List.is_status.includes({user: [:user_profile]}, :taggings).order('created_at').first(10) #新着のプレイリスト
  
      #Customer取得
      @customer = find_or_create_stripe_customer(current_user)
      
      #パラメータでcodeがあればstripeのデータ取得
      if params[:code] != nil
        set_stripe_id(current_user, params[:code])
      end
      
    end
  end
  
  def welecome
  end
  
  def samplelist
  end

  def chart
    #セレクトボックス用のタグ
    taggings = set_list_genre
    @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
    @tag.unshift("All genre") #先頭に"All genre"追加

    #パラメータからリスト抽出
    if chart_params[:genre] == "All genre" || chart_params[:genre].nil? #ジャンルが空だったら
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        @genre_list = List.is_status.includes({user: [:user_profile]}, :taggings).order(:created_at)
      else  # ランキングの場合
        @genre_list = List.is_status.includes({user: [:user_profile]}, :taggings).joins(:list_favorites).group(:list_id).order('count(list_id) desc')
      end
    else
      genre = List.tagged_with(chart_params[:genre]).pluck(:id)#ジャンルの対象のリストのIDの一覧取得
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        @genre_list = List.is_status.includes({user: [:user_profile]}, :taggings).where(id: genre).order(:created_at)
      else  # ランキングの場合
        @genre_list = List.is_status.includes({user: [:user_profile]}, :taggings).joins(:list_favorites).where(id: genre).group(:list_id).order('count(list_id) desc')
      end
    end

    @pages = @genre_list.page(params[:page])
    #Customer取得
    @customer = find_or_create_stripe_customer(current_user)
  end
  
  def privacy
    
  end
  
  def term
    
  end
  
  def tokutei
    
  end

  def search
    #Customer取得
    @customer = find_or_create_stripe_customer(current_user)
  end

  private

  def genre_params
    params.permit(:user_search, :list_search)
  end

  def chart_params
    params.permit(:genre, :sort)
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
