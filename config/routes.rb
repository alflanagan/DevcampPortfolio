# frozen_string_literal: true

Rails.application.routes.draw do
  resources :topics
  devise_for :users, path: '', path_names: { sign_in: 'login',
                                             sign_out: 'logout',
                                             sign_up: 'register' }
  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'about-me', to: 'pages#about'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :blogs do
    member do
      get :toggle_status
    end
  end
  get 'blog/:id', to: 'blogs#show', as: 'blog_show'

  get 'skills', to: 'skills#index', as: 'skills_index'
  get 'skills/:id', to: 'skills#edit', as: 'skill_edit'
  patch 'skills/:id', to: 'skills#update', as: 'skill'

  mount ActionCable.server => '/cable'

  root to: 'pages#home'
end
