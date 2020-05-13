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

    it 'should set expiry_at before create to be 30 days from created_at' do
      expect(subject.save).to be true
      expect(subject.expiry_at).to eql(subject.created_at + 30.days)
    end
  end

  describe 'associations' do
    it { should have_many(:visits) }
  end

  describe '#top_countries_with_count(limit)' do
    def create_visit(country = nil)
      ip_v6_address = Faker::Internet.ip_v6_address
      subject.visits.create(ip_address: ip_v6_address, country: country)
    end

    let(:countries) { 4.times.map { Faker::Address.country } }
    before(:each) { subject.save }

    it 'should return top 3 countries with count' do
      countries.each_with_index do |c, i|
        (i + 1).times { create_visit(c) }
      end

      result = subject.top_countries_with_count(3)

      expect(result[countries[3]]).to eql(4)
      expect(result[countries[2]]).to eql(3)
      expect(result[countries[1]]).to eql(2)
    end

    it 'should return an empty hash when there are no country data' do
      5.times { create_visit }
      expect(subject.top_countries_with_count(3)).to be_empty
    end
  end
end
