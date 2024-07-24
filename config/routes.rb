# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'goals#index'
  resources :goals, only: %i[new create show edit update destroy] do
    resources :reports, only: %i[new create]
  end
  devise_for :users
end
