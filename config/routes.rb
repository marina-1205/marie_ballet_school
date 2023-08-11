Rails.application.routes.draw do
  namespace :admin do
    get 'reserves/index'
    get 'reserves/show'
  end
  namespace :admin do
    get 'lesson_classes/index'
    get 'lesson_classes/edit'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/edit'
    get 'customers/index'
    get 'customers/show'
  end
  namespace :admin do
    get 'genres/edit'
    get 'genres/index'
  end
  namespace :admin do
    get 'items/edit'
    get 'items/index'
    get 'items/new'
    get 'items/show'
  end
  namespace :admin do
    get 'homes/create'
    get 'homes/destroy'
    get 'homes/home'
  end
  namespace :public do
    get 'reserves/new'
    get 'reserves/complete'
  end
  namespace :public do
    get 'orders/completed'
    get 'orders/confirm'
    get 'orders/index'
    get 'orders/show'
    get 'orders/new'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'customers/edit'
    get 'customers/show'
    get 'customers/confirm_withdraw'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
 # 顧客用
 devise_for :customers,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
 }

 # 管理者用
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
 }

 namespace :admin do
    get "/" => "homes#top"
    get "search" => "searches#search"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :edit, :create, :update, :new]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    get 'customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch '/customers/infomation' => 'customers#update'
    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch '/customers/withdraw' => 'customers#withdraw'
    #ジャンル検索
    resources :genres, only: [:show]
    resources :items, only: [:index, :show]
    resource :customers, only: [:new, :create, :show, :edit, :update]
    resources :addresses, only: [:new, :index, :create, :edit, :update, :destroy]
    #検索
    get "search" => "searches#search"
    resources :orders, only: [:new, :create, :index, :show] do
      # データ全体に行いたいのでcollection
      collection do
        post 'confirm'
        get 'completed'
      end
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'clear'
      end
    end
  end

end
