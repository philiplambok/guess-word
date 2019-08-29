# frozen_string_literal: true

module Web
  class RankingsController < ApplicationController
    def index
      @users = User.order(point: :desc)
    end
  end
end
