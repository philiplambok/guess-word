# frozen_string_literal: true

module Web
  class WordsController < ApplicationController
    def new
      @word = Word.new
    end

    def create
      create_word = CreateWord.new(word_params)
      create_word.call
      if create_word.success?
        flash[:success] = 'Kata berhasil ditambahkan, terima kasih telah berkontribusi'
      else
        flash[:danger] = create_word.errors.join(',')
      end
      redirect_to new_word_path
    end

    private

    def word_params
      params.require(:word).permit(:text)
    end
  end
end
