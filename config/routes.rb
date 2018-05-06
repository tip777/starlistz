Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users/registrations", :confirmations => "users/confirmations"}

  root 'home#index'
  get 'home/show'
  # get 'name_check', to: 'home#name_check'#ユーザー名重複チェック用
  get 'chart' , to: 'home#chart' #チャート
  get 'about' , to: 'home#about' #プレイリストについて
  get 'privacy' , to: 'home#privacy' #個人情報保護
  get 'term' , to: 'home#term' #利用規約
  #著作権どうするか
  # get 'copyright' , to: 'home#copyright'
  get 'faq' , to: 'home#faq' #よくある質問
  get 'support' , to: 'home#support' #お問い合わせ

  resources :lists do #プレイリスト用
    put :sort
    get :saleslist#売り上げ管理用
  end
  resources :charges #決済用

  resources :relationships, only: [:create, :destroy]#フォロー、アンフォロー
  resources :favorites, only: [:create, :destroy]#プレイリストお気に入り、解除
  
  #ユーザー確認画面
  get "users/:id/playlist" => "users#playlist", as: 'users_playlist'
  get "users/:id/purchasehistory" => "users#purchasehistory", as: 'users_purchasehistory' #購入履歴ページ
  get "users/:id/salesmanage" => "users#salesmanage", as: 'users_salesmanage' #売り上げ管理ページ
  
  #検索
  get 'searches/playlist'
  get 'searches/user'
  get 'searches/playlist_genre'
  get 'searches/user_genre'
  
  

  

end
