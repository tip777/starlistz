class HomeController < ApplicationController
  before_action :gon_current_user, only: [:index, :show, :chart, :search]
  require "google/cloud/bigquery"


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
      
      @newusers = User.includes(:user_profile).order(created_at: :desc).limit(5)
      @newlists = List.is_status.includes({user: [:user_profile]}, :taggings).order(created_at: :desc).first(10) #新着のプレイリスト
      
      
      #Customer取得
      @customer = find_or_create_stripe_customer(current_user)
      
      #パラメータでcodeがあればstripeのデータ取得
      if params[:code] != nil
        set_stripe_id(current_user, params[:code])
      end
      
    end
  end

  def auto_complete_song
    if !params[:term].nil?
      begin
        song_title = []

        searchTxt = params[:term].gsub(" ", "")
        searchFirstStr = params[:term][0].upcase
        if searchFirstStr.match(/[0-9]/)
          searchFirstStr = "Num"
        elsif !searchFirstStr.match(/[A-Z]/)
          searchFirstStr = "Other"
        end
        
        creds = Google::Cloud::Bigquery::Credentials.new Rails.application.credentials.gcs_starlistz_key
        bigquery = Google::Cloud::Bigquery.new(
          project: "starlistz",
          keyfile: creds #認証用JSONキーファイル
        )

        sql = "SELECT title FROM `starlistz.discogs_track.track_#{searchFirstStr}` WHERE REGEXP_CONTAINS(REPLACE(title,' ',''), '^(?i)#{searchTxt}.*$') LIMIT 5;"


        # Location must match that of the dataset(s) referenced in the query.
        results = bigquery.query sql do |config|
          config.location = "US"
        end

        results.each do |row|
          song_title.push(row[:title])
        end

      rescue => e
      end
    end

    render json: song_title.to_json
  end

  def auto_complete_artist
    begin
      # artist_title = []

      # searchTxt = params[:term].gsub(" ", "")

      # creds = Google::Cloud::Bigquery::Credentials.new Rails.application.credentials.gcs_starlistz_key

      # bigquery = Google::Cloud::Bigquery.new(
      #   project: "starlistz",
      #   keyfile: creds #認証用JSONキーファイル
      # )

      # sql = "SELECT name FROM `starlistz.discogs_data.artist` WHERE REGEXP_CONTAINS(REPLACE(name,' ',''), '^(?i)#{searchTxt}.*$') LIMIT 5;"

      # # Location must match that of the dataset(s) referenced in the query.
      # results = bigquery.query sql do |config|
      #   config.location = "US"
      # end

      # results.each do |row|
      #   artist_title.push(row[:name])
      # end

      #アルファベットごとに分けて検索
      artist_title = []

      searchTxt = params[:term].gsub(" ", "")
      searchFirstStr = params[:term][0].upcase
      if !searchFirstStr.match(/[A-Z]/)
        searchFirstStr = "Other"
      end

      creds = Google::Cloud::Bigquery::Credentials.new Rails.application.credentials.gcs_starlistz_key

      bigquery = Google::Cloud::Bigquery.new(
        project: "starlistz",
        keyfile: creds #認証用JSONキーファイル
      )
      # binding.pry
      sql = "SELECT name FROM `starlistz.discogs_multi_data.artist_#{searchFirstStr}` WHERE REGEXP_CONTAINS(REPLACE(name,' ',''), '^(?i)#{searchTxt}.*$') LIMIT 5;"

      # Location must match that of the dataset(s) referenced in the query.
      results = bigquery.query sql do |config|
        config.location = "US"
      end

      results.each do |row|
        artist_title.push(row[:name])
      end

    rescue => e
    end

    render json: artist_title.to_json
  end
  
  def welecome
  end
  
  def samplelist
  end

  def chart
    #セレクトボックス用のタグ
    taggings = set_list_mood
    @tag = ActsAsTaggableOn::Tag.where(id: taggings).pluck(:name)
    @tag.unshift("All mood") #先頭に"All mood"追加

    #パラメータからリスト抽出
    if chart_params[:mood] == "All mood" || chart_params[:mood].nil? #ジャンルが空だったら
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        @mood_list = List.is_status.includes({user: [:user_profile]}, :taggings).order(created_at: :desc)
      else  # ランキングの場合
        @mood_list = List.is_status.includes({user: [:user_profile]}, :taggings).joins(:list_favorites).group(:list_id).order('count(list_id) desc')
      end
    else
      listMood_ids = List.tagged_with(chart_params[:mood]).pluck(:id)#ジャンルの対象のリストのIDの一覧取得
      if chart_params[:sort] == "new" || chart_params[:sort].nil? #sortが新着or空欄の場合
        @mood_list = List.is_status.includes({user: [:user_profile]}, :taggings).where(id: listMood_ids).order(created_at: :desc)
      else  # ランキングの場合
        @mood_list = List.is_status.includes({user: [:user_profile]}, :taggings).joins(:list_favorites).where(id: listMood_ids).group(:list_id).order('count(list_id) desc')
      end
    end

    @pages = @mood_list.page(params[:page])
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

  def chart_params
    params.permit(:mood, :sort)
  end


end
