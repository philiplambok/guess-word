# frozen_string_literal: true

module Api
  module V1
    class WordsController < ApplicationController
      def show
        word = Word.find_by(id: params[:id])
        if word.blank?
          render json: { error: 'Word not found' }
          return false
        end
        render json: {
          id: word.id,
          text: word.text
        }
      end
    end
  end
end
