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
  end
  
  scope module: :public do
    root 'homes#top'
    get "/about" => "homes#about"
    get 'members/mypage' => 'members#show', as: 'mypage'
    get 'members/index' => 'members#index'
    # members/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'confirm_unsubscribe'
    put 'members/information' => 'members#update'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw_members'
    get 'wines/myindex/:id' => 'wines#myindex', as: 'wines_myindex'
    get 'wines/again_index/:id' => 'wines#again_index', as: 'wines_again_index'
    resources :wines, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      #1人のメンバーは1つの投稿に対して1回しかいいねできないためいいねのidはURLに含める必要がない(params[:id]を使わなくても良い)
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :spots, only: [:index, :show, :create, :new, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
