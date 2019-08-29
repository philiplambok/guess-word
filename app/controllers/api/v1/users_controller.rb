# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def update
        user = User.find_by(id: params[:id])
        if user.blank?
          render json: { error: 'User not found' }
          return false
        end
        user.update(user_params)
        render json: user
      end

      private

      def user_params
        params.require(:user).permit(:point)
      end
    end
  end
end
