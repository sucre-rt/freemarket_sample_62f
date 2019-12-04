Rails.application.routes.draw do
  devise_for :users, 
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:  'users/registrations'
  },  #callback関数を呼び出せるようにする
  skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  root 'main#index'
  
  resources :mypage, only: [:index]

  as :mypage do
    get 'logout', to: 'mypage#logout', as: :logout_mypage
    get 'mypage/card', to: 'mypage#card', as: :card_mypage
    get 'mypage/like/history', to: 'mypage#like', as: :like_mypage
  end

  
  
  resources :signup, only: [:create, :index, :update] do
    collection do
      get 'registration'
      get 'sms_confirmation'
      scope :sms_confirmation do
        get 'sms', to: 'signup#sms'
      end
      get 'address'
      get 'credit_card'
      get 'done'
    end
  end
  as :signup do
    get 'mypage/profile', to: 'signup#profile', as: :profile_signup
  end

  resources :products, only: [:create, :show, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    collection do
      get 'sell'
      get 'done'
      get 'search'
      #ajax用
      get 'delivery_children'
      get 'category_children' 
      get 'category_grandchildren'
      get ":id/category_children", to: 'products#category_children'
      get ":id/category_grandchildren", to: 'products#category_grandchildren'
      get ':id/delivery_children', to: 'products#delivery_children'
    end
    member do
      get 'pay'
      post 'buy'
    end
    resources :messages, only: [:create]
  end

  resources :comments, only: [:show] do
    get 'comment/'
  end
    

  resources :card, only: [:create, :destroy]
  as :card do
    get 'mypage/card/create', to: 'card#new', as: :card_new
  end

end
