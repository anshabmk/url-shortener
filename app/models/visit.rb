class Visit < ApplicationRecord
  belongs_to :short_link, counter_cache: true
end
