class SecretCode < ApplicationRecord
  belongs_to :user, optional: true
  attr_accessor :number_of_codes
  before_create :set_code

  self.per_page = 15 # pagination 15 records per page

  def set_code
    begin
      self.code = SecureRandom.hex(6)
    end while self.class.exists?(:code => code)
  end
end
