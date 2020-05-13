class ShortLink < ApplicationRecord
  TOKEN_LENGTH = 5

  has_many :visits

  validates :token, presence: true,
                    uniqueness: true,
                    length: { is: TOKEN_LENGTH },
                    format: { with: Regexp.new("[a-zA-Z0-9]{#{TOKEN_LENGTH}}") }
  
  validates :long_url, presence: true

  before_validation :set_token, on: :create
  before_create :set_expiry_at

  def top_countries_with_count(limit)
    visits.select(:country)
          .where.not(country: nil)
          .group(:country)
          .order(count: :desc)
          .limit(limit)
          .count
  end

  private

    def set_token
      self.token = SecureRandom.alphanumeric(TOKEN_LENGTH)

      set_token if ShortLink.where(token: self.token).exists?
    end

    def set_expiry_at
      self.expiry_at = self.created_at + 30.days
    end
end
