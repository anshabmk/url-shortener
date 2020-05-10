class ShortLink < ApplicationRecord
  validates :token, presence: true, 
                    length: { is: 5 }, 
                    format: { with: /[a-zA-Z0-9]{5}/ }
end
