Rails.application.routes.draw do
  namespace :admins_backoffice do
    get 'questions/index'
  end
  devise_for :admins, skip: [:registrations]
  devise_for :users

  namespace :admins_backoffice do
    get 'admins/index'
  end
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
  end

  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
  end

  namespace :admins_backoffice do
    resources :welcome, only: [:index]
    resources :admins
    resources :subjects
    resources :questions
  end

  get 'inicio', to: 'site/welcome#index'
  root 'site/welcome#index'
end
