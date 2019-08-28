# frozen_string_literal: true

module Web
  module Users
    class PlaygroundController < ApplicationController
      def index
        @user = User.find_by(id: params[:id])
        redirect_to root_path if @user.blank?
      end
    end
  end
end
