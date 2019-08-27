# frozen_string_literal: true

module Web
  class WelcomeController < ApplicationController
    def index
      @user = User.new
    end
  end
end
