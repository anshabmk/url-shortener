class ShortLink < ApplicationRecord
  validates :token, presence: true,
                    uniqueness: true,
                    length: { is: 5 },
                    format: { with: /[a-zA-Z0-9]{5}/ }
  
  validates :long_url, presence: true

  before_validation :set_token

  private

    def set_token
      self.token = Faker::Alphanumeric.alphanumeric(number: 5)
    end
end
