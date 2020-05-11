require 'rails_helper'

RSpec.describe "ShortLinks", type: :request do
  let(:random_url) { Faker::Internet.url }
  let(:random_token) { Faker::Alphanumeric.alphanumeric(number: 5) }

  it 'creates a short link' do
    get '/short_links/new'
    expect(response).to render_template(:new)

    post '/short_links', xhr: true, params: { short_link: { long_url: random_url } }
    expect(response).to render_template(:create)
  end

  it 'redirects to the long url with status code 301' do
    short_link = ShortLink.create(long_url: random_url)

    get "/#{short_link.token}"
    expect(response).to redirect_to(short_link.long_url)
    expect(response.code).to eql('301')
  end

  it 'renders 404 not found for a non-existing token' do
    get "/#{random_token}"
    expect(response.body).to eql('Not found.')
    expect(response.code).to eql('404')
  end
end
