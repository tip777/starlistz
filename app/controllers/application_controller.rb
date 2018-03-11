class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_header
      # @q = User.ransack(params[:q])
      # @search_user = @q.result(distinct: true)
      #
      # @q2 = List.ransack(params[:q])
      # @search_list = @q2.result(distinct: true)

      # binding.pry
      if params[:q] != nil
        keword = params[:q][:name_cont]
        @q = User.ransack(name_cont: keword)
        @search_user = @q.result(distinct: true)

        @q2 = List.ransack(title_cont: keword)
        @search_list = @q2.result(distinct: true)
      else
        @q = User.ransack(params[:q])
      end

      # binding.pry
      # key_words = params[:q][:name_cont].split(/[\p{blank}\s]+/) # スペースがあったら分ける
      # grouping_hash = key_words.reduce({}){|hash, word| hash.merge(word => { name_cont: word })}
      # @q = User.ransack({ combinator: 'and', groupings: grouping_hash, s: 'name desc' })
      # @search_user = @q.result(distinct: true)
      #
      # grouping_hash2 = key_words.reduce({}){|hash, word| hash.merge(word => { title_cont: word })}
      # @search_list = List.ransack({ combinator: 'and', groupings: grouping_hash, s: 'title desc' }).result(distinct: true)

      # binding.pry
      # key_words = params[:q][:q].split(/[\p{blank}\s]+/) # スペースがあったら分ける
      # @q = User.ransack(name_cont: key_words)
      # @search_user = @q.result(distinct: true)
      #
      # @search_list = List.ransack(title_cont: key_words).result(distinct: true)
  end

  def set_list_genre
    #Listのタグだけ抽出
    return ActsAsTaggableOn::Tagging.where(taggable_type: "List").group("tag_id").pluck(:tag_id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #アカウント登録時にnameカラムも登録
    #user edit ジャンルのselectbox用
    devise_parameter_sanitizer.permit(:account_update,
           keys: [:tag_list, :user_profiles => [:id,:user_id, :description, :insta_url, :tw_url, :avatar]]) #userモデル編集時にプロフィールも編集
  end
end
