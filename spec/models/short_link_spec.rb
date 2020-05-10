require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  let(:random_url) { Faker::Internet.url }
  let(:random_token) { Faker::Alphanumeric.alphanumeric(number: 5) }

  context 'token' do
    it 'should not save without a token' do
      short_link = ShortLink.new(long_url: random_url)
  
      expect(short_link.save).to be false
    end

    it 'should not save if the length of the token is not 5' do
      short_link = ShortLink.new(
        long_url: random_url,
        token: Faker::Alphanumeric.alphanumeric(number: Random.rand(6..10))
      )

      expect(short_link.save).to be false
    end

    it 'should not contain anything other than alphanumeric as token' do
      short_link = ShortLink.new(long_url: random_url, token: 'abc1@')

      expect(short_link.save).to be false
    end

    it 'should not save if token is not unique' do
      token = random_token
      short_link1 = ShortLink.create!(long_url: random_url, token: token)
      short_link2 = ShortLink.new(long_url: random_url, token: token)

      expect(short_link2.save).to be false
    end

    it 'should save if valid token is given' do
      short_link = ShortLink.new(long_url: random_url, token: random_token)

      expect(short_link.save).to be true
    end
  end
end
