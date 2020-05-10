require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  context 'token' do
    it 'should not save without a token' do
      short_link = ShortLink.new(long_url: Faker::Internet.url)
  
      expect(short_link.save).to be false
    end

    it 'should not save if the length of the token is not 5' do
      short_link = ShortLink.new(
        long_url: Faker::Internet.url, 
        token: Faker::Alphanumeric.alphanumeric(number: Random.rand(6..10))
      )

      expect(short_link.save).to be false
    end

    it 'should not contain anything other than alphanumeric as token' do
      short_link = ShortLink.new(
        long_url: Faker::Internet.url,
        token: 'abc1@'
      )

      expect(short_link.save).to be false
    end

    it 'should not save if token is not unique' do
      token = Faker::Alphanumeric.alphanumeric(number: 5)

      short_link1 = ShortLink.create!(
        long_url: Faker::Internet.url,
        token: token
      )

      short_link2 = ShortLink.new(
        long_url: Faker::Internet.url,
        token: token
      )

      expect(short_link2.save).to be false
    end

    it 'should save if valid token is given' do
      short_link = ShortLink.new(
        long_url: Faker::Internet.url,
        token: Faker::Alphanumeric.alphanumeric(number: 5)
      )

      expect(short_link.save).to be true
    end
  end
end
