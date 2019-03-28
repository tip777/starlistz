Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users/registrations", :confirmations => "users/confirmations"}

  root 'home#index'
  get 'samplelist' , to: 'home#samplelist' #サンプルプレイリスト
  # get 'name_check', to: 'home#name_check'#ユーザー名重複チェック用
  get 'chart' , to: 'home#chart' #チャート
  get 'about' , to: 'home#about' #プレイリストについて
  get 'privacy' , to: 'home#privacy' #個人情報保護
  get 'term' , to: 'home#term' #利用規約
  get 'tokutei' , to: 'home#tokutei' #特定商取引に関する表記
  #著作権どうするか
  # get 'copyright' , to: 'home#copyright'

  #お問い合わせ
  get 'contact' => 'contact#index'
  post 'contact/thanks' => 'contact#thanks'
  get 'contact/unsubscribe' => 'contact#unsubscribe'

  resources :lists do #プレイリスト用
    put :sort
  end
  resources :charges #決済用
  # resources :person_infos, expect: [:show, :new, :edit] #個人情報
  
  resources :relationships, only: [:create, :destroy]   #フォロー、アンフォロー
  resources :favorites, only: [:create, :destroy]       #プレイリストお気に入り、解除

  #ユーザー確認画面
  get "users/:id/playlist" => "users#playlist", as: 'users_playlist'
  get "users/:id/purchasehistory" => "users#purchasehistory", as: 'users_purchasehistory' #購入履歴
  get "users/:id/favuser" => "users#favuser", as: 'users_favuser'                         #お気に入りユーザー
  get "users/:id/favplaylist" => "users#favplaylist", as: 'users_favplaylist'             #お気に入りプレイリスト
  get "users/:id/salesmanage" => "users#salesmanage", as: 'users_salesmanage'             #売り上げ管理ページ
  get "users/:id/salesmonth" => "users#salesmonth", as: 'users_salesmonth'                #月間売り上げ管理ページ
  get "users/:id/payment" => "users#payment", as: 'users_payment'                         #決済設定
  #個人情報登録ページ
  get 'users/:id/person_info', to: 'person_info#index', as: 'person_info' 
  post 'users/:id/person_info', to: 'person_info#create'
  patch 'users/:id/person_info', to: 'person_info#update'
  put 'users/:id/person_info', to: 'person_info#update'
  delete 'users/:id/person_info', to: 'person_info#destroy'

  #検索
  get 'searches/all_result'
  get 'searches/playlist'
  get 'searches/user'

  #　twitter連携　解除用
  delete 'disconnect', to: 'social_profile#destroy'
  
end
