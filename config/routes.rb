# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/welcome#index'

  scope module: :web do
    resources :users, only: %i[create] do
      member do
        resources :playground, only: %i[index],
                               module: :users,
                               as: :user_playground
      end
    end
    resources :abouts, only: %i[index]
    resources :rankings, only: %i[index]
    resources :words, only: %i[new create]
  end

  namespace :api do
    namespace :v1 do
      resources :random_words, only: %i[index]
      resources :words, only: %i[show]
      resources :users, only: %i[update]
    end
  end
end
