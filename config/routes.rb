Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users/registrations",}

  root 'home#index'
  get 'home/show'


  resources :users, :only => [:show] #User MyPage
  resources :lists #プレイリスト用
  
  get 'chart' , to: 'home#chart' #チャート
  get 'genre' , to: 'home#genre' #ジャンル一覧
  get 'search' , to: 'home#search' #検索結果
  get 'about' , to: 'home#about' #プレイリストについて
  get 'privacy' , to: 'home#privacy' #個人情報保護
  get 'term' , to: 'home#term' #利用規約
  #著作権どうするか
  # get 'copyright' , to: 'home#copyright'
  get 'faq' , to: 'home#faq' #よくある質問
  get 'support' , to: 'home#support' #お問い合わせ

end
