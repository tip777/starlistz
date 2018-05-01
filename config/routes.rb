Rails.application.routes.draw do
  get 'searches/playlist'

  get 'searches/user'

  get 'searches/playlist_genre'

  get 'searches/user_genre'

  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users/registrations", :confirmations => "users/confirmations"}

  root 'home#index'
  get 'home/show'
  # get 'name_check', to: 'home#name_check'#ユーザー名重複チェック用


#フォロー、フォロワー　ページ用
  # resources :users, :only => [:show] do
  #   member do
  #      get 'following'
  #      get 'follower'
  #     # get 'favoriting'
  #   end
  #  end

  resources :users, :only => [:show]

  resources :lists do #プレイリスト用
    put :sort
  end
  resources :charges #決済用

  resources :relationships, only: [:create, :destroy]#フォロー、アンフォロー
  resources :favorites, only: [:create, :destroy]#プレイリストお気に入り、解除
  
  resources :searches, only: [:playlist, :user, :playlistgenre, :usergenre]#プレイリストお気に入り、解除

  get 'chart' , to: 'home#chart' #チャート
  # get 'search/playlist' , to: 'home#playlist' #検索　プレイリスト
  # get 'search/user' , to: 'home#user' #検索　ユーザー
  # get 'search/list_genre' , to: 'home#listgenre' #検索　プレイリストジャンル
  # get 'search/user_genre' , to: 'home#usergenre' #検索　ユーザージャンル
  get 'about' , to: 'home#about' #プレイリストについて
  get 'privacy' , to: 'home#privacy' #個人情報保護
  get 'term' , to: 'home#term' #利用規約
  #著作権どうするか
  # get 'copyright' , to: 'home#copyright'
  get 'faq' , to: 'home#faq' #よくある質問
  get 'support' , to: 'home#support' #お問い合わせ

end
