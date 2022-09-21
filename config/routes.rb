Rails.application.routes.draw do
  devise_for :profiles
  devise_for :admins
  root 'welcome#index'
end
