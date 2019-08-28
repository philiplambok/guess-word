# frozen_string_literal: true

module Api
  module V1
    class RandomWordsController < ApplicationController
      def index
        words = Word.all
        word_sample = words.sample
        word_sample_text = word_sample.text
        random_word_service = RandomWord.new(word_sample_text)
        random_word_service.generate
        random_word = random_word_service.random_word
        render json: {
          id: word_sample.id,
          random_word: random_word
        }
      end
    end
  end
end
