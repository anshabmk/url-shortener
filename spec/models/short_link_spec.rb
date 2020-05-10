require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  context 'token' do
    it 'should validate presence of token' do
      short_link = ShortLink.new(long_url: Faker::Internet.url)
  
      expect(short_link.save).to be false
    end
  end
end
