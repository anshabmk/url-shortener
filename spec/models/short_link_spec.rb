require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  let(:random_url) { Faker::Internet.url }

  subject { described_class.new(long_url: random_url) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without long url' do
      subject.long_url = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without token' do
      expect(subject.save).to be true
      subject.token = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if the length of the token is not 5' do
      expect(subject.save).to be true
      invalid_length = [1, 2, 3, 4, 6, 7].sample
      subject.token = Faker::Alphanumeric.alphanumeric(number: invalid_length)
      expect(subject).to_not be_valid
    end

    it 'is not valid if token is not alphanumeric' do
      expect(subject.save).to be true
      subject.token = 'ab12@'
      expect(subject).to_not be_valid
    end

    it 'is not valid if token is not unique' do
      expect(subject.save).to be true

      another_subject = described_class.new(long_url: random_url)
      expect(another_subject.save).to be true

      another_subject.token = subject.token
      expect(another_subject).to_not be_valid
    end
  end

  describe 'Callbacks' do
    it 'should set a token before validation on create' do
      expect(subject.token).to be_nil
      expect(subject).to be_valid
      expect(subject.token).to_not be_nil
    end

    it 'should not reset the token before validation on update' do
      expect(subject.save).to be true
      current_token = subject.token
      subject.update(long_url: random_url)
      expect(subject.token).to eql(current_token)
    end
  end

  describe 'Default values' do
    it 'should have default value of 0 for clicks_count' do
      expect(subject.save).to be true
      expect(subject.clicks_count).to eql(0)
    end
  end
end
