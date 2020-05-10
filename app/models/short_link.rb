class ShortLink < ApplicationRecord
  validates_presence_of :token
end
