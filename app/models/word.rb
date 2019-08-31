# frozen_string_literal: true

class Word < ApplicationRecord
  validates :text, presence: true
  validates :text, uniqueness: { case_sensitive: false }
  validates :text, format: { without: /\s/, message: 'tidak boleh mengandung spasi' }
  validates :text, format: { without: /\d/, message: 'tidak boleh mengandung angka' }
  validates :text, format: { without: /\W/, message: 'tidak boleh mengandung simbol' }
  validates :text, length: { in: 3..20, message: 'harus memiliki panjang karakter 3 - 20' }
end
