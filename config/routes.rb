Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }  #callback関数を呼び出せるようにする
  
  root 'main#index'
  resources :mypage, only: [:index]
  resources :login, only: [:index]
  
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

end
