Rails.application.routes.draw do

  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users/registrations", :confirmations => "users/confirmations"}

  root 'home#index'
  get 'home/show'
  # get 'name_check', to: 'home#name_check'#ユーザー名重複チェック用
  get 'chart' , to: 'home#chart' #チャート
  get 'about' , to: 'home#about' #プレイリストについて
  get 'privacy' , to: 'home#privacy' #個人情報保護
  get 'term' , to: 'home#term' #利用規約
  get 'tokutei' , to: 'home#tokutei' #特定商取引に関する表記
  #著作権どうするか
  # get 'copyright' , to: 'home#copyright'
  get 'faq' , to: 'home#faq' #よくある質問

  #お問い合わせ
  get 'contact' => 'contact#index'
  post 'contact/thanks' => 'contact#thanks'
  get 'contact/unsubscribe' => 'contact#unsubscribe'

  resources :lists do #プレイリスト用
    put :sort
  end
  resources :charges #決済用

  resources :relationships, only: [:create, :destroy]#フォロー、アンフォロー
  resources :favorites, only: [:create, :destroy]#プレイリストお気に入り、解除

  #ユーザー確認画面
  get "users/:id/playlist" => "users#playlist", as: 'users_playlist'
  get "users/:id/purchasehistory" => "users#purchasehistory", as: 'users_purchasehistory' #購入履歴
  get "users/:id/payouthistory" => "users#account#payouthistory", as: 'payouthistory' #振込履歴
  get "users/:id/favuser" => "users#favuser", as: 'users_favuser' #お気に入りユーザー
  get "users/:id/favplaylist" => "users#favplaylist", as: 'users_favplaylist' #お気に入りプレイリスト
  get "users/:id/salesmanage" => "users#salesmanage", as: 'users_salesmanage' #売り上げ管理ページ
  get "users/:id/salesmonth" => "users#salesmonth", as: 'users_salesmonth' #月間売り上げ管理ページ
  get "users/:id/payment_info" => "users#customer#payment_info", as: 'payment_info' #支払い方法
  get "users/:id/account_info" => "users#account#account_info", as: 'account_info' #販売者情報
  get "users/:id/business_info" => "users#account#business_info", as: 'business_info' #販売業者情報
  get "users/:id/bank_info" => "users#account#bank_info", as: 'bank_info' #口座情報
  get "users/:id/account_tokutei" => "users#account_tokutei", as: 'account_tokutei' #特商法表示に基づく表示

  #検索
  get 'searches/playlist'
  get 'searches/user'
  get 'searches/playlist_genre'
  get 'searches/user_genre'

  #　twitter連携　解除用
  delete 'disconnect', to: 'social_profile#destroy'





end
