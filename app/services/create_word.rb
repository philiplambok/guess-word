# frozen_string_literal: true

class CreateWord
  attr_reader :errors

  def initialize(params)
    @params = params
  end

  def call
    word = Word.new(@params)
    word.valid?
    if word.errors.any?
      @errors = word.errors.full_messages
      return false
    end

    word.text = word.text.downcase
    word.save
  end

  def success?
    @errors.blank? ? true : false
  end
end
