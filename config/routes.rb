# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'goals#index'
  resources :goals do
    resources :reports, only: %i[new create edit update destroy]
  end
  devise_for :users
end
