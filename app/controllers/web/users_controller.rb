# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        redirect_to user_playground_index_path(user)
      else
        flash[:error] = user.errors.full_messages.join(', ')
        redirect_to root_path
      end
    end

    private

    def user_params
      params.require(:user).permit(:name)
    end
  end
end
