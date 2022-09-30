Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :site do
    get 'welcome/index'
  end

  namespace :users_backoffice do
    get 'welcome/index'
  end

  namespace :admins_backoffice do
    get 'welcome/index'
  end

  get 'inicio', to: 'site/welcome#index'

  root 'site/welcome#index'
end
