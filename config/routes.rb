Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
    get "search" => "searches#search"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :edit, :create, :update, :new]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    resources :reserves, only: [:index, :show, :update]
    resources :lesson_classes, only: [:index, :edit, :create, :update]
  end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    get 'customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch '/customers/infomation' => 'customers#update'
    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :genres, only: [:show]
    resources :items, only: [:index]
    get '/items/:id', to: 'items#show', as: 'item'
    
    resource :customers, only: [:new, :create, :show, :edit, :update]
    
    get 'reserves' => 'reserves#new'
    resources :reserves, only: [:create,] do
    collection do
      get :complete
    end
  end

    resources :orders, only: [:new, :create, :index, :show] do
      # データ全体に行いたいのでcollection
      collection do
        post 'confirm'
        get 'confirm' => "orders#get_confirm"
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