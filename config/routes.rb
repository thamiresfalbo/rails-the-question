Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :users
  
  namespace :admins_backoffice do
    get 'admins/index'
  end
  namespace :site do
    get 'welcome/index'
  end

  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
  end

  namespace :admins_backoffice do
    resources :welcome, only: [:index]
    resources :admins
  end

  get 'inicio', to: 'site/welcome#index'
  root 'site/welcome#index'
end
