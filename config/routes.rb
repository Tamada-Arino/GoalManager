# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'goals#index'
  resources :goals, only: %i[new create show edit update destroy]
  devise_for :users
end
