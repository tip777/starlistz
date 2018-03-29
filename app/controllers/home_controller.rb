class HomeController < ApplicationController
before_action :stripe
  def index
    taggings = set_list_genre
    @genre = ActsAsTaggableOn::Tag.where(id: taggings).order("taggings_count").first(10) #トップ10　ジャンル
    @newlist = List.order('created_at').first(20) #新着のプレイリスト
  end

  def show
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

     @pages = @genre_list.page(params[:page])
  end

  def stripe
    require 'net/http'
    require 'uri'

    uri = URI.parse("https://connect.stripe.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "client_secret" => "sk_test_cqhiyTcvoKhdGDSMYa7YY3Kr",
      "code" => "ac_CW3BNmomboRYJfukpCpFC8sKZ3t8JMio",
      "grant_type" => "authorization_code",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    result = ActiveSupport::JSON.decode(response.body)
    response.code
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
