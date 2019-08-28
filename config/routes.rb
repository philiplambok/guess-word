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
  end

  scope :api, module: :api, path: :api do
    scope :v1, module: :v1, path: :v1 do
      resources :random_words, only: %i[index]
    end
  end
end
