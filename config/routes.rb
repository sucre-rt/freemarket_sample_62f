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
  resources :users do
    resources :mypage, only: [:index]
  end

  
  root 'main#index'
  
  resources :signup do
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

  resources :products do
    collection do
      get 'sell'
    end
  end

end
