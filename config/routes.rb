Rails.application.routes.draw do
  devise_for :users
  namespace :site do
    get 'welcome/index'
  end

  namespace :profiles_backoffice do
    get 'welcome/index'
  end

  namespace :admins_backoffice do
    get 'welcome/index'
  end

  devise_for :admins

  get 'inicio', to: 'site/welcome#index'

  root 'site/welcome#index'
end
