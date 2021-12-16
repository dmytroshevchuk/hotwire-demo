# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'issues#index'

  resources :issues, except: %i[index show]
  get '/:status', to: 'issues#index', as: :issues_status
end
