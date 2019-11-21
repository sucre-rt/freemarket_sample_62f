Rails.application.routes.draw do
  devise_for :users, 
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
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
  end

  as :addresses do
    get 'mypage/identification', to: 'addresses#edit', as: :identification_addresses
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

  resources :products do
    collection do
      get 'sell'
    end
  end

end
