class ShortLink < ApplicationRecord
  validates :token, presence: true,
                    uniqueness: true,
                    length: { is: 5 },
                    format: { with: /[a-zA-Z0-9]{5}/ }
  
  validates :long_url, presence: true

  before_validation :set_token, on: :create

  private

    def set_token
      self.token = SecureRandom.alphanumeric(5)

      set_token if ShortLink.where(token: self.token).exists?
    end
end
