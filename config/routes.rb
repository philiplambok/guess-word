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
end
