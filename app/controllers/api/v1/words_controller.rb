# frozen_string_literal: true

module Api
  module V1
    class WordsController < ApplicationController
      def show
        word = Word.find_by(id: params[:id])
        render json: {
          id: word.id,
          text: word.text
        }
      end
    end
  end
end
