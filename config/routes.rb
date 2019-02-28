Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  authenticate :user do
    resources :tasks, except: %i[edit new]
    resources :users, only: %i[update]
  end
  ActiveAdmin.routes(self)
end
