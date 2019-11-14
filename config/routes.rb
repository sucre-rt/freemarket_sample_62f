Rails.application.routes.draw do
  root 'main#index'
  resources :mypage, only: [:index]
end
