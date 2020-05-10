class ShortLink < ApplicationRecord
  validates_presence_of :token
  validates :token, length: { is: 5 }
end
