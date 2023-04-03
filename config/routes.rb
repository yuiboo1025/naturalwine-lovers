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
  end
  
  scope module: :public do
    root 'homes#top'
    get "/about" => "homes#about"
    get 'members/mypage' => 'members#show', as: 'mypage'
    # members/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'confirm_unsubscribe'
    put 'members/information' => 'members#update'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw_members'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
