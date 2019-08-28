# frozen_string_literal: true

class RandomWord
  attr_reader :random_word

  def initialize(word)
    @plain_word = word
  end

  def generate
    if @plain_word.blank?
      @random_word = ''
      return true
    end

    text_array = @plain_word.split('')
    uniq_text = text_array.uniq

    if uniq_text.size.eql?(1)
      @random_word = @plain_word
      return true
    end

    loop do
      array_size = text_array.size
      @random_word = text_array.sample(array_size).join('')
      next if @random_word.eql?(@plain_word)

      break
    end
  end
end
