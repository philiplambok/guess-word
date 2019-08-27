# frozen_string_literal: true

module Web
  module Users
    class PlaygroundController < ApplicationController
      def index
        @user = User.find_by(id: params[:id])
      end
    end
  end
end
