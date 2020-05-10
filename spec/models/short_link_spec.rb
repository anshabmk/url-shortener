require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  context 'token' do
    it 'should not save the record without a token' do
      short_link = ShortLink.new(long_url: Faker::Internet.url)
  
      expect(short_link.save).to be false
    end

    it 'should not save the record if the length of the token is not 5' do
      short_link = ShortLink.new(
        long_url: Faker::Internet.url, 
        token: Faker::Alphanumeric.alphanumeric(number: Random.rand(6..10))
      )

      expect(short_link.save).to be false
    end
  end
end
