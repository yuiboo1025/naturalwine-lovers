Rails.application.routes.draw do
  #root to: 'homes#top'
  #get "/about" => "homes#about"

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :members, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :wines, only: [:index, :show, :edit, :update, :destroy]
    resources :spots, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root 'homes#top'
    get "/about" => "homes#about"
    # members/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    #get 'members/information/edit' => 'members#edit', as: 'edit_information'
   # patch 'members/information' => 'members#update', as: 'update_information'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'confirm_unsubscribe'
    #put 'members/information' => 'members#update'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw_members'
    resources :members, only: [:index,:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
  	  #get 'followings' => 'relationships#followings', as: 'followings'
  	  #get 'followers' => 'relationships#followers', as: 'followers'
  	  #member doを使うと、ユーザーidが含まれてるurlを使えるようになる。
  	  member do
        get :bookmarks, :followings, :followers
      end
    end
    get 'wines/myindex/:id' => 'wines#myindex', as: 'wines_myindex'
    get 'wines/again_index/:id' => 'wines#again_index', as: 'wines_again_index'
    resources :wines, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      #1人のメンバーは1つの投稿に対して1回しかいいねできないためいいねのidはURLに含める必要がない(params[:id]を使わなくても良い)
      resource :favorites, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :spots, only: [:index, :show, :create, :new, :edit, :update]
  end

  #ゲストログイン用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
