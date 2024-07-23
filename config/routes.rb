# frozen_string_literal: true

Rails.application.routes.draw do
  get 'goals/index'
  devise_for :users
end
