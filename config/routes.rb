Rails.application.routes.draw do
  devise_for :users
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
  root 'main#index'
end
